///===
/// extcore/ds_list_chunked

pub(all) struct DslistchunkedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_chunked_make_point(x : Double, y : Double) -> DslistchunkedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_chunked_make_point3(x : Double, y : Double, z : Double) -> DslistchunkedPoint {
  { x, y, z, label: 0 }
}

pub fn ds_list_chunked_point_x(pt : DslistchunkedPoint) -> Double { pt.x }

pub fn ds_list_chunked_point_y(pt : DslistchunkedPoint) -> Double { pt.y }

pub fn ds_list_chunked_point_z(pt : DslistchunkedPoint) -> Double { pt.z }

pub fn ds_list_chunked_point_label(pt : DslistchunkedPoint) -> Int { pt.label }

pub fn ds_list_chunked_point_dist(a : DslistchunkedPoint, b : DslistchunkedPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_list_chunked_point_add(a : DslistchunkedPoint, b : DslistchunkedPoint) -> DslistchunkedPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_list_chunked_point_sub(a : DslistchunkedPoint, b : DslistchunkedPoint) -> DslistchunkedPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_list_chunked_point_scale(pt : DslistchunkedPoint, s : Double) -> DslistchunkedPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_list_chunked_point_dot(a : DslistchunkedPoint, b : DslistchunkedPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_list_chunked_point_cross(a : DslistchunkedPoint, b : DslistchunkedPoint) -> DslistchunkedPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_list_chunked_point_norm(pt : DslistchunkedPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_list_chunked_point_normalize(pt : DslistchunkedPoint) -> DslistchunkedPoint {
  let n = ds_list_chunked_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_list_chunked_point_scale(pt, 1.0 / n) }
}

pub fn ds_list_chunked_point_negate(pt : DslistchunkedPoint) -> DslistchunkedPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_list_chunked_point_mid(a : DslistchunkedPoint, b : DslistchunkedPoint) -> DslistchunkedPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_list_chunked_point_lerp(a : DslistchunkedPoint, b : DslistchunkedPoint, t : Double) -> DslistchunkedPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_list_chunked_point_to_string(pt : DslistchunkedPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DslistchunkedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_chunked_make_series(vals : Array[Double], name : String) -> DslistchunkedSeries {
  { vals, name, meta: 0 }
}

pub fn ds_list_chunked_series_len(s : DslistchunkedSeries) -> Int { s.vals.length() }

pub fn ds_list_chunked_series_sum(s : DslistchunkedSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_list_chunked_series_mean(s : DslistchunkedSeries) -> Double {
  let n = ds_list_chunked_series_len(s)
  if n == 0 { 0.0 } else { ds_list_chunked_series_sum(s) / n.to_double() }
}

pub fn ds_list_chunked_series_min(s : DslistchunkedSeries) -> Double {
  let n = ds_list_chunked_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_list_chunked_series_max(s : DslistchunkedSeries) -> Double {
  let n = ds_list_chunked_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_list_chunked_series_range(s : DslistchunkedSeries) -> Double {
  ds_list_chunked_series_max(s) - ds_list_chunked_series_min(s)
}

pub fn ds_list_chunked_series_var(s : DslistchunkedSeries) -> Double {
  let n = ds_list_chunked_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_list_chunked_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_list_chunked_series_std(s : DslistchunkedSeries) -> Double { @_common.sqrt(ds_list_chunked_series_var(s)) }

pub fn ds_list_chunked_series_median(s : DslistchunkedSeries) -> Double {
  let n = ds_list_chunked_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_list_chunked_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_list_chunked_series_scale(s : DslistchunkedSeries, f : Double) -> DslistchunkedSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_list_chunked_series_add(a : DslistchunkedSeries, b : DslistchunkedSeries) -> DslistchunkedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_list_chunked_series_sub(a : DslistchunkedSeries, b : DslistchunkedSeries) -> DslistchunkedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_list_chunked_series_normalize(s : DslistchunkedSeries) -> DslistchunkedSeries {
  let mn = ds_list_chunked_series_min(s)
  let mx = ds_list_chunked_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_list_chunked_series_cumsum(s : DslistchunkedSeries) -> DslistchunkedSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_list_chunked_series_to_string(s : DslistchunkedSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistchunkedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_chunked_make_matrix(rows : Int, cols : Int, val : Double) -> DslistchunkedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_chunked_matrix_identity(n : Int) -> DslistchunkedMatrix {
  let m = ds_list_chunked_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_list_chunked_matrix_get(m : DslistchunkedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_list_chunked_matrix_transpose(m : DslistchunkedMatrix) -> DslistchunkedMatrix {
  let result = ds_list_chunked_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_list_chunked_matrix_add(a : DslistchunkedMatrix, b : DslistchunkedMatrix) -> DslistchunkedMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_list_chunked_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_list_chunked_matrix_scale(m : DslistchunkedMatrix, s : Double) -> DslistchunkedMatrix {
  let result = ds_list_chunked_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_list_chunked_matrix_multiply(a : DslistchunkedMatrix, b : DslistchunkedMatrix) -> DslistchunkedMatrix {
  if a.cols != b.rows { return ds_list_chunked_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_list_chunked_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_list_chunked_matrix_trace(m : DslistchunkedMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_list_chunked_matrix_det(m : DslistchunkedMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_list_chunked_matrix_norm(m : DslistchunkedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_list_chunked_matrix_to_string(m : DslistchunkedMatrix) -> String {
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

pub(all) struct DslistchunkedVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_chunked_make_vector(comps : Array[Double]) -> DslistchunkedVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_chunked_vector_zero(dim : Int) -> DslistchunkedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_list_chunked_vector_add(a : DslistchunkedVector, b : DslistchunkedVector) -> DslistchunkedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_list_chunked_vector_sub(a : DslistchunkedVector, b : DslistchunkedVector) -> DslistchunkedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_list_chunked_vector_scale(v : DslistchunkedVector, s : Double) -> DslistchunkedVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_list_chunked_vector_dot(a : DslistchunkedVector, b : DslistchunkedVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_list_chunked_vector_norm(v : DslistchunkedVector) -> Double { @_common.sqrt(ds_list_chunked_vector_dot(v, v)) }

pub fn ds_list_chunked_vector_normalize(v : DslistchunkedVector) -> DslistchunkedVector {
  let n = ds_list_chunked_vector_norm(v)
  if n < 0.0000001 { v } else { ds_list_chunked_vector_scale(v, 1.0 / n) }
}

pub fn ds_list_chunked_vector_dist(a : DslistchunkedVector, b : DslistchunkedVector) -> Double {
  ds_list_chunked_vector_norm(ds_list_chunked_vector_sub(a, b))
}

pub fn ds_list_chunked_vector_to_string(v : DslistchunkedVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_chunked_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_list_chunked_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_list_chunked_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_list_chunked_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_list_chunked_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_list_chunked_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_list_chunked_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_list_chunked_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_list_chunked_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_list_chunked_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_list_chunked_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_list_chunked_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_list_chunked_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_list_chunked_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_list_chunked_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_list_chunked_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_list_chunked_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_list_chunked_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_list_chunked_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_list_chunked_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_list_chunked_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_list_chunked_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_list_chunked_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_list_chunked_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_list_chunked_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_list_chunked_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_list_chunked_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_list_chunked_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_list_chunked_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DslistchunkedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_frame_make(size : Int) -> DslistchunkedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_frame_len(s : DslistchunkedFrame) -> Int { s.size }

pub fn ds_list_chunked_frame_get(s : DslistchunkedFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_frame_set(s : DslistchunkedFrame, i : Int, v : Double) -> DslistchunkedFrame {
  let result = ds_list_chunked_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_frame_sum(s : DslistchunkedFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_chunked_frame_mean(s : DslistchunkedFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_chunked_frame_sum(s) / s.size.to_double() }
}

pub fn ds_list_chunked_frame_scale(s : DslistchunkedFrame, f : Double) -> DslistchunkedFrame {
  let result = ds_list_chunked_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_chunked_frame_add(a : DslistchunkedFrame, b : DslistchunkedFrame) -> DslistchunkedFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_chunked_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_chunked_frame_copy(s : DslistchunkedFrame) -> DslistchunkedFrame {
  let result = ds_list_chunked_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_chunked_frame_fill(s : DslistchunkedFrame, v : Double) -> DslistchunkedFrame {
  let result = ds_list_chunked_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_frame_min(s : DslistchunkedFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_frame_max(s : DslistchunkedFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_frame_to_string(s : DslistchunkedFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_table_make(size : Int) -> DslistchunkedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_table_len(s : DslistchunkedTable) -> Int { s.size }

pub fn ds_list_chunked_table_get(s : DslistchunkedTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_table_set(s : DslistchunkedTable, i : Int, v : Double) -> DslistchunkedTable {
  let result = ds_list_chunked_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_table_sum(s : DslistchunkedTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_chunked_table_mean(s : DslistchunkedTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_chunked_table_sum(s) / s.size.to_double() }
}

pub fn ds_list_chunked_table_scale(s : DslistchunkedTable, f : Double) -> DslistchunkedTable {
  let result = ds_list_chunked_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_chunked_table_add(a : DslistchunkedTable, b : DslistchunkedTable) -> DslistchunkedTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_chunked_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_chunked_table_copy(s : DslistchunkedTable) -> DslistchunkedTable {
  let result = ds_list_chunked_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_chunked_table_fill(s : DslistchunkedTable, v : Double) -> DslistchunkedTable {
  let result = ds_list_chunked_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_table_min(s : DslistchunkedTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_table_max(s : DslistchunkedTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_table_to_string(s : DslistchunkedTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_graphn_make(size : Int) -> DslistchunkedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_graphn_len(s : DslistchunkedGraphN) -> Int { s.size }

pub fn ds_list_chunked_graphn_get(s : DslistchunkedGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_graphn_set(s : DslistchunkedGraphN, i : Int, v : Double) -> DslistchunkedGraphN {
  let result = ds_list_chunked_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_graphn_sum(s : DslistchunkedGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_chunked_graphn_mean(s : DslistchunkedGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_chunked_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_list_chunked_graphn_scale(s : DslistchunkedGraphN, f : Double) -> DslistchunkedGraphN {
  let result = ds_list_chunked_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_chunked_graphn_add(a : DslistchunkedGraphN, b : DslistchunkedGraphN) -> DslistchunkedGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_chunked_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_chunked_graphn_copy(s : DslistchunkedGraphN) -> DslistchunkedGraphN {
  let result = ds_list_chunked_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_chunked_graphn_fill(s : DslistchunkedGraphN, v : Double) -> DslistchunkedGraphN {
  let result = ds_list_chunked_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_graphn_min(s : DslistchunkedGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_graphn_max(s : DslistchunkedGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_graphn_to_string(s : DslistchunkedGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_node_make(size : Int) -> DslistchunkedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_node_len(s : DslistchunkedNode) -> Int { s.size }

pub fn ds_list_chunked_node_get(s : DslistchunkedNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_node_set(s : DslistchunkedNode, i : Int, v : Double) -> DslistchunkedNode {
  let result = ds_list_chunked_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_node_sum(s : DslistchunkedNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_chunked_node_mean(s : DslistchunkedNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_chunked_node_sum(s) / s.size.to_double() }
}

pub fn ds_list_chunked_node_scale(s : DslistchunkedNode, f : Double) -> DslistchunkedNode {
  let result = ds_list_chunked_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_chunked_node_add(a : DslistchunkedNode, b : DslistchunkedNode) -> DslistchunkedNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_chunked_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_chunked_node_copy(s : DslistchunkedNode) -> DslistchunkedNode {
  let result = ds_list_chunked_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_chunked_node_fill(s : DslistchunkedNode, v : Double) -> DslistchunkedNode {
  let result = ds_list_chunked_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_node_min(s : DslistchunkedNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_node_max(s : DslistchunkedNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_node_to_string(s : DslistchunkedNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_edge_make(size : Int) -> DslistchunkedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_edge_len(s : DslistchunkedEdge) -> Int { s.size }

pub fn ds_list_chunked_edge_get(s : DslistchunkedEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_edge_set(s : DslistchunkedEdge, i : Int, v : Double) -> DslistchunkedEdge {
  let result = ds_list_chunked_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_edge_sum(s : DslistchunkedEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_chunked_edge_mean(s : DslistchunkedEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_chunked_edge_sum(s) / s.size.to_double() }
}

pub fn ds_list_chunked_edge_scale(s : DslistchunkedEdge, f : Double) -> DslistchunkedEdge {
  let result = ds_list_chunked_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_chunked_edge_add(a : DslistchunkedEdge, b : DslistchunkedEdge) -> DslistchunkedEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_chunked_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_chunked_edge_copy(s : DslistchunkedEdge) -> DslistchunkedEdge {
  let result = ds_list_chunked_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_chunked_edge_fill(s : DslistchunkedEdge, v : Double) -> DslistchunkedEdge {
  let result = ds_list_chunked_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_edge_min(s : DslistchunkedEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_edge_max(s : DslistchunkedEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_edge_to_string(s : DslistchunkedEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_path_make(size : Int) -> DslistchunkedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_path_len(s : DslistchunkedPath) -> Int { s.size }

pub fn ds_list_chunked_path_get(s : DslistchunkedPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_path_set(s : DslistchunkedPath, i : Int, v : Double) -> DslistchunkedPath {
  let result = ds_list_chunked_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_path_sum(s : DslistchunkedPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_chunked_path_mean(s : DslistchunkedPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_chunked_path_sum(s) / s.size.to_double() }
}

pub fn ds_list_chunked_path_scale(s : DslistchunkedPath, f : Double) -> DslistchunkedPath {
  let result = ds_list_chunked_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_chunked_path_add(a : DslistchunkedPath, b : DslistchunkedPath) -> DslistchunkedPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_chunked_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_chunked_path_copy(s : DslistchunkedPath) -> DslistchunkedPath {
  let result = ds_list_chunked_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_chunked_path_fill(s : DslistchunkedPath, v : Double) -> DslistchunkedPath {
  let result = ds_list_chunked_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_path_min(s : DslistchunkedPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_path_max(s : DslistchunkedPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_path_to_string(s : DslistchunkedPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_cluster_make(size : Int) -> DslistchunkedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_cluster_len(s : DslistchunkedCluster) -> Int { s.size }

pub fn ds_list_chunked_cluster_get(s : DslistchunkedCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_cluster_set(s : DslistchunkedCluster, i : Int, v : Double) -> DslistchunkedCluster {
  let result = ds_list_chunked_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_cluster_sum(s : DslistchunkedCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_chunked_cluster_mean(s : DslistchunkedCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_chunked_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_list_chunked_cluster_scale(s : DslistchunkedCluster, f : Double) -> DslistchunkedCluster {
  let result = ds_list_chunked_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_chunked_cluster_add(a : DslistchunkedCluster, b : DslistchunkedCluster) -> DslistchunkedCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_chunked_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_chunked_cluster_copy(s : DslistchunkedCluster) -> DslistchunkedCluster {
  let result = ds_list_chunked_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_chunked_cluster_fill(s : DslistchunkedCluster, v : Double) -> DslistchunkedCluster {
  let result = ds_list_chunked_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_cluster_min(s : DslistchunkedCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_cluster_max(s : DslistchunkedCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_cluster_to_string(s : DslistchunkedCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_model_make(size : Int) -> DslistchunkedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_model_len(s : DslistchunkedModel) -> Int { s.size }

pub fn ds_list_chunked_model_get(s : DslistchunkedModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_model_set(s : DslistchunkedModel, i : Int, v : Double) -> DslistchunkedModel {
  let result = ds_list_chunked_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_model_sum(s : DslistchunkedModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_chunked_model_mean(s : DslistchunkedModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_chunked_model_sum(s) / s.size.to_double() }
}

pub fn ds_list_chunked_model_scale(s : DslistchunkedModel, f : Double) -> DslistchunkedModel {
  let result = ds_list_chunked_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_chunked_model_add(a : DslistchunkedModel, b : DslistchunkedModel) -> DslistchunkedModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_chunked_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_chunked_model_copy(s : DslistchunkedModel) -> DslistchunkedModel {
  let result = ds_list_chunked_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_chunked_model_fill(s : DslistchunkedModel, v : Double) -> DslistchunkedModel {
  let result = ds_list_chunked_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_model_min(s : DslistchunkedModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_model_max(s : DslistchunkedModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_model_to_string(s : DslistchunkedModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_layer_make(size : Int) -> DslistchunkedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_layer_len(s : DslistchunkedLayer) -> Int { s.size }

pub fn ds_list_chunked_layer_get(s : DslistchunkedLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_layer_set(s : DslistchunkedLayer, i : Int, v : Double) -> DslistchunkedLayer {
  let result = ds_list_chunked_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_layer_sum(s : DslistchunkedLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_chunked_layer_mean(s : DslistchunkedLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_chunked_layer_sum(s) / s.size.to_double() }
}

pub fn ds_list_chunked_layer_scale(s : DslistchunkedLayer, f : Double) -> DslistchunkedLayer {
  let result = ds_list_chunked_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_chunked_layer_add(a : DslistchunkedLayer, b : DslistchunkedLayer) -> DslistchunkedLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_chunked_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_chunked_layer_copy(s : DslistchunkedLayer) -> DslistchunkedLayer {
  let result = ds_list_chunked_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_chunked_layer_fill(s : DslistchunkedLayer, v : Double) -> DslistchunkedLayer {
  let result = ds_list_chunked_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_layer_min(s : DslistchunkedLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_layer_max(s : DslistchunkedLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_layer_to_string(s : DslistchunkedLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_buffer_make(size : Int) -> DslistchunkedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_buffer_len(s : DslistchunkedBuffer) -> Int { s.size }

pub fn ds_list_chunked_buffer_get(s : DslistchunkedBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_buffer_set(s : DslistchunkedBuffer, i : Int, v : Double) -> DslistchunkedBuffer {
  let result = ds_list_chunked_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_buffer_sum(s : DslistchunkedBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_chunked_buffer_mean(s : DslistchunkedBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_chunked_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_list_chunked_buffer_scale(s : DslistchunkedBuffer, f : Double) -> DslistchunkedBuffer {
  let result = ds_list_chunked_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_chunked_buffer_add(a : DslistchunkedBuffer, b : DslistchunkedBuffer) -> DslistchunkedBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_chunked_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_chunked_buffer_copy(s : DslistchunkedBuffer) -> DslistchunkedBuffer {
  let result = ds_list_chunked_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_chunked_buffer_fill(s : DslistchunkedBuffer, v : Double) -> DslistchunkedBuffer {
  let result = ds_list_chunked_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_buffer_min(s : DslistchunkedBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_buffer_max(s : DslistchunkedBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_buffer_to_string(s : DslistchunkedBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_cursor_make(size : Int) -> DslistchunkedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_cursor_len(s : DslistchunkedCursor) -> Int { s.size }

pub fn ds_list_chunked_cursor_get(s : DslistchunkedCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_cursor_set(s : DslistchunkedCursor, i : Int, v : Double) -> DslistchunkedCursor {
  let result = ds_list_chunked_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_cursor_sum(s : DslistchunkedCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_chunked_cursor_mean(s : DslistchunkedCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_chunked_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_list_chunked_cursor_scale(s : DslistchunkedCursor, f : Double) -> DslistchunkedCursor {
  let result = ds_list_chunked_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_chunked_cursor_add(a : DslistchunkedCursor, b : DslistchunkedCursor) -> DslistchunkedCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_chunked_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_chunked_cursor_copy(s : DslistchunkedCursor) -> DslistchunkedCursor {
  let result = ds_list_chunked_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_chunked_cursor_fill(s : DslistchunkedCursor, v : Double) -> DslistchunkedCursor {
  let result = ds_list_chunked_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_cursor_min(s : DslistchunkedCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_cursor_max(s : DslistchunkedCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_cursor_to_string(s : DslistchunkedCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_view_make(size : Int) -> DslistchunkedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_view_len(s : DslistchunkedView) -> Int { s.size }

pub fn ds_list_chunked_view_get(s : DslistchunkedView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_view_set(s : DslistchunkedView, i : Int, v : Double) -> DslistchunkedView {
  let result = ds_list_chunked_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_view_sum(s : DslistchunkedView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_chunked_view_mean(s : DslistchunkedView) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_chunked_view_sum(s) / s.size.to_double() }
}

pub fn ds_list_chunked_view_scale(s : DslistchunkedView, f : Double) -> DslistchunkedView {
  let result = ds_list_chunked_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_chunked_view_add(a : DslistchunkedView, b : DslistchunkedView) -> DslistchunkedView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_chunked_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_chunked_view_copy(s : DslistchunkedView) -> DslistchunkedView {
  let result = ds_list_chunked_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_chunked_view_fill(s : DslistchunkedView, v : Double) -> DslistchunkedView {
  let result = ds_list_chunked_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_view_min(s : DslistchunkedView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_view_max(s : DslistchunkedView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_view_to_string(s : DslistchunkedView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_range_make(size : Int) -> DslistchunkedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_range_len(s : DslistchunkedRange) -> Int { s.size }

pub fn ds_list_chunked_range_get(s : DslistchunkedRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_range_set(s : DslistchunkedRange, i : Int, v : Double) -> DslistchunkedRange {
  let result = ds_list_chunked_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_range_sum(s : DslistchunkedRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_chunked_range_mean(s : DslistchunkedRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_chunked_range_sum(s) / s.size.to_double() }
}

pub fn ds_list_chunked_range_scale(s : DslistchunkedRange, f : Double) -> DslistchunkedRange {
  let result = ds_list_chunked_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_chunked_range_add(a : DslistchunkedRange, b : DslistchunkedRange) -> DslistchunkedRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_chunked_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_chunked_range_copy(s : DslistchunkedRange) -> DslistchunkedRange {
  let result = ds_list_chunked_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_chunked_range_fill(s : DslistchunkedRange, v : Double) -> DslistchunkedRange {
  let result = ds_list_chunked_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_range_min(s : DslistchunkedRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_range_max(s : DslistchunkedRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_range_to_string(s : DslistchunkedRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_slice_make(size : Int) -> DslistchunkedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_slice_len(s : DslistchunkedSlice) -> Int { s.size }

pub fn ds_list_chunked_slice_get(s : DslistchunkedSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_slice_set(s : DslistchunkedSlice, i : Int, v : Double) -> DslistchunkedSlice {
  let result = ds_list_chunked_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_slice_sum(s : DslistchunkedSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_chunked_slice_mean(s : DslistchunkedSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_chunked_slice_sum(s) / s.size.to_double() }
}

pub fn ds_list_chunked_slice_scale(s : DslistchunkedSlice, f : Double) -> DslistchunkedSlice {
  let result = ds_list_chunked_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_chunked_slice_add(a : DslistchunkedSlice, b : DslistchunkedSlice) -> DslistchunkedSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_chunked_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_chunked_slice_copy(s : DslistchunkedSlice) -> DslistchunkedSlice {
  let result = ds_list_chunked_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_chunked_slice_fill(s : DslistchunkedSlice, v : Double) -> DslistchunkedSlice {
  let result = ds_list_chunked_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_chunked_slice_min(s : DslistchunkedSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_slice_max(s : DslistchunkedSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_chunked_slice_to_string(s : DslistchunkedSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

