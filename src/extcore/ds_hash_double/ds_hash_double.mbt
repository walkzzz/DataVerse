///===
/// extcore/ds_hash_double

pub(all) struct DshashdoublePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_double_make_point(x : Double, y : Double) -> DshashdoublePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_double_make_point3(x : Double, y : Double, z : Double) -> DshashdoublePoint {
  { x, y, z, label: 0 }
}

pub fn ds_hash_double_point_x(pt : DshashdoublePoint) -> Double { pt.x }

pub fn ds_hash_double_point_y(pt : DshashdoublePoint) -> Double { pt.y }

pub fn ds_hash_double_point_z(pt : DshashdoublePoint) -> Double { pt.z }

pub fn ds_hash_double_point_label(pt : DshashdoublePoint) -> Int { pt.label }

pub fn ds_hash_double_point_dist(a : DshashdoublePoint, b : DshashdoublePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_hash_double_point_add(a : DshashdoublePoint, b : DshashdoublePoint) -> DshashdoublePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_hash_double_point_sub(a : DshashdoublePoint, b : DshashdoublePoint) -> DshashdoublePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_hash_double_point_scale(pt : DshashdoublePoint, s : Double) -> DshashdoublePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_hash_double_point_dot(a : DshashdoublePoint, b : DshashdoublePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_hash_double_point_cross(a : DshashdoublePoint, b : DshashdoublePoint) -> DshashdoublePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_hash_double_point_norm(pt : DshashdoublePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_hash_double_point_normalize(pt : DshashdoublePoint) -> DshashdoublePoint {
  let n = ds_hash_double_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_hash_double_point_scale(pt, 1.0 / n) }
}

pub fn ds_hash_double_point_negate(pt : DshashdoublePoint) -> DshashdoublePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_hash_double_point_mid(a : DshashdoublePoint, b : DshashdoublePoint) -> DshashdoublePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_hash_double_point_lerp(a : DshashdoublePoint, b : DshashdoublePoint, t : Double) -> DshashdoublePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_hash_double_point_to_string(pt : DshashdoublePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DshashdoubleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_double_make_series(vals : Array[Double], name : String) -> DshashdoubleSeries {
  { vals, name, meta: 0 }
}

pub fn ds_hash_double_series_len(s : DshashdoubleSeries) -> Int { s.vals.length() }

pub fn ds_hash_double_series_sum(s : DshashdoubleSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_hash_double_series_mean(s : DshashdoubleSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_hash_double_series_min(s : DshashdoubleSeries) -> Double { @_common.min(s.vals) }

pub fn ds_hash_double_series_max(s : DshashdoubleSeries) -> Double { @_common.max(s.vals) }

pub fn ds_hash_double_series_range(s : DshashdoubleSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_hash_double_series_var(s : DshashdoubleSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_hash_double_series_std(s : DshashdoubleSeries) -> Double { @_common.std(s.vals) }

pub fn ds_hash_double_series_median(s : DshashdoubleSeries) -> Double { @_common.median(s.vals) }

pub fn ds_hash_double_series_scale(s : DshashdoubleSeries, f : Double) -> DshashdoubleSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_hash_double_series_add(a : DshashdoubleSeries, b : DshashdoubleSeries) -> DshashdoubleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_hash_double_series_sub(a : DshashdoubleSeries, b : DshashdoubleSeries) -> DshashdoubleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_hash_double_series_normalize(s : DshashdoubleSeries) -> DshashdoubleSeries {
  let mn = ds_hash_double_series_min(s)
  let mx = ds_hash_double_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_hash_double_series_cumsum(s : DshashdoubleSeries) -> DshashdoubleSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_hash_double_series_to_string(s : DshashdoubleSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashdoubleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_double_make_matrix(rows : Int, cols : Int, val : Double) -> DshashdoubleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_double_matrix_identity(n : Int) -> DshashdoubleMatrix {
  let m = ds_hash_double_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_hash_double_matrix_get(m : DshashdoubleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_hash_double_matrix_transpose(m : DshashdoubleMatrix) -> DshashdoubleMatrix {
  let result = ds_hash_double_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_hash_double_matrix_add(a : DshashdoubleMatrix, b : DshashdoubleMatrix) -> DshashdoubleMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_hash_double_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_hash_double_matrix_scale(m : DshashdoubleMatrix, s : Double) -> DshashdoubleMatrix {
  let result = ds_hash_double_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_hash_double_matrix_multiply(a : DshashdoubleMatrix, b : DshashdoubleMatrix) -> DshashdoubleMatrix {
  if a.cols != b.rows { return ds_hash_double_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_hash_double_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_hash_double_matrix_trace(m : DshashdoubleMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_hash_double_matrix_det(m : DshashdoubleMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_hash_double_matrix_norm(m : DshashdoubleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_hash_double_matrix_to_string(m : DshashdoubleMatrix) -> String {
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

pub(all) struct DshashdoubleVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_double_make_vector(comps : Array[Double]) -> DshashdoubleVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_double_vector_zero(dim : Int) -> DshashdoubleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_hash_double_vector_add(a : DshashdoubleVector, b : DshashdoubleVector) -> DshashdoubleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_double_vector_sub(a : DshashdoubleVector, b : DshashdoubleVector) -> DshashdoubleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_double_vector_scale(v : DshashdoubleVector, s : Double) -> DshashdoubleVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_hash_double_vector_dot(a : DshashdoubleVector, b : DshashdoubleVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_hash_double_vector_norm(v : DshashdoubleVector) -> Double { @_common.sqrt(ds_hash_double_vector_dot(v, v)) }

pub fn ds_hash_double_vector_normalize(v : DshashdoubleVector) -> DshashdoubleVector {
  let n = ds_hash_double_vector_norm(v)
  if n < 0.0000001 { v } else { ds_hash_double_vector_scale(v, 1.0 / n) }
}

pub fn ds_hash_double_vector_dist(a : DshashdoubleVector, b : DshashdoubleVector) -> Double {
  ds_hash_double_vector_norm(ds_hash_double_vector_sub(a, b))
}

pub fn ds_hash_double_vector_to_string(v : DshashdoubleVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_double_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_hash_double_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_hash_double_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_hash_double_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_hash_double_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_hash_double_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_hash_double_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_hash_double_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_hash_double_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_hash_double_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_hash_double_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_hash_double_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_hash_double_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_hash_double_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_hash_double_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_hash_double_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_hash_double_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_hash_double_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_hash_double_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_hash_double_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_hash_double_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_hash_double_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_hash_double_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_hash_double_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_hash_double_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_hash_double_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_hash_double_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_hash_double_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_hash_double_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DshashdoubleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_frame_make(size : Int) -> DshashdoubleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_frame_len(s : DshashdoubleFrame) -> Int { s.size }

pub fn ds_hash_double_frame_get(s : DshashdoubleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_frame_set(s : DshashdoubleFrame, i : Int, v : Double) -> DshashdoubleFrame {
  let result = ds_hash_double_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_frame_sum(s : DshashdoubleFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_double_frame_mean(s : DshashdoubleFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_double_frame_sum(s) / s.size.to_double() }
}

pub fn ds_hash_double_frame_scale(s : DshashdoubleFrame, f : Double) -> DshashdoubleFrame {
  let result = ds_hash_double_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_double_frame_add(a : DshashdoubleFrame, b : DshashdoubleFrame) -> DshashdoubleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_double_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_double_frame_copy(s : DshashdoubleFrame) -> DshashdoubleFrame {
  let result = ds_hash_double_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_double_frame_fill(s : DshashdoubleFrame, v : Double) -> DshashdoubleFrame {
  let result = ds_hash_double_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_frame_min(s : DshashdoubleFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_frame_max(s : DshashdoubleFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_frame_to_string(s : DshashdoubleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_table_make(size : Int) -> DshashdoubleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_table_len(s : DshashdoubleTable) -> Int { s.size }

pub fn ds_hash_double_table_get(s : DshashdoubleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_table_set(s : DshashdoubleTable, i : Int, v : Double) -> DshashdoubleTable {
  let result = ds_hash_double_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_table_sum(s : DshashdoubleTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_double_table_mean(s : DshashdoubleTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_double_table_sum(s) / s.size.to_double() }
}

pub fn ds_hash_double_table_scale(s : DshashdoubleTable, f : Double) -> DshashdoubleTable {
  let result = ds_hash_double_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_double_table_add(a : DshashdoubleTable, b : DshashdoubleTable) -> DshashdoubleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_double_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_double_table_copy(s : DshashdoubleTable) -> DshashdoubleTable {
  let result = ds_hash_double_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_double_table_fill(s : DshashdoubleTable, v : Double) -> DshashdoubleTable {
  let result = ds_hash_double_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_table_min(s : DshashdoubleTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_table_max(s : DshashdoubleTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_table_to_string(s : DshashdoubleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_graphn_make(size : Int) -> DshashdoubleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_graphn_len(s : DshashdoubleGraphN) -> Int { s.size }

pub fn ds_hash_double_graphn_get(s : DshashdoubleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_graphn_set(s : DshashdoubleGraphN, i : Int, v : Double) -> DshashdoubleGraphN {
  let result = ds_hash_double_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_graphn_sum(s : DshashdoubleGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_double_graphn_mean(s : DshashdoubleGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_double_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_hash_double_graphn_scale(s : DshashdoubleGraphN, f : Double) -> DshashdoubleGraphN {
  let result = ds_hash_double_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_double_graphn_add(a : DshashdoubleGraphN, b : DshashdoubleGraphN) -> DshashdoubleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_double_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_double_graphn_copy(s : DshashdoubleGraphN) -> DshashdoubleGraphN {
  let result = ds_hash_double_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_double_graphn_fill(s : DshashdoubleGraphN, v : Double) -> DshashdoubleGraphN {
  let result = ds_hash_double_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_graphn_min(s : DshashdoubleGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_graphn_max(s : DshashdoubleGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_graphn_to_string(s : DshashdoubleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_node_make(size : Int) -> DshashdoubleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_node_len(s : DshashdoubleNode) -> Int { s.size }

pub fn ds_hash_double_node_get(s : DshashdoubleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_node_set(s : DshashdoubleNode, i : Int, v : Double) -> DshashdoubleNode {
  let result = ds_hash_double_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_node_sum(s : DshashdoubleNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_double_node_mean(s : DshashdoubleNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_double_node_sum(s) / s.size.to_double() }
}

pub fn ds_hash_double_node_scale(s : DshashdoubleNode, f : Double) -> DshashdoubleNode {
  let result = ds_hash_double_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_double_node_add(a : DshashdoubleNode, b : DshashdoubleNode) -> DshashdoubleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_double_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_double_node_copy(s : DshashdoubleNode) -> DshashdoubleNode {
  let result = ds_hash_double_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_double_node_fill(s : DshashdoubleNode, v : Double) -> DshashdoubleNode {
  let result = ds_hash_double_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_node_min(s : DshashdoubleNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_node_max(s : DshashdoubleNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_node_to_string(s : DshashdoubleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_edge_make(size : Int) -> DshashdoubleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_edge_len(s : DshashdoubleEdge) -> Int { s.size }

pub fn ds_hash_double_edge_get(s : DshashdoubleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_edge_set(s : DshashdoubleEdge, i : Int, v : Double) -> DshashdoubleEdge {
  let result = ds_hash_double_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_edge_sum(s : DshashdoubleEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_double_edge_mean(s : DshashdoubleEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_double_edge_sum(s) / s.size.to_double() }
}

pub fn ds_hash_double_edge_scale(s : DshashdoubleEdge, f : Double) -> DshashdoubleEdge {
  let result = ds_hash_double_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_double_edge_add(a : DshashdoubleEdge, b : DshashdoubleEdge) -> DshashdoubleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_double_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_double_edge_copy(s : DshashdoubleEdge) -> DshashdoubleEdge {
  let result = ds_hash_double_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_double_edge_fill(s : DshashdoubleEdge, v : Double) -> DshashdoubleEdge {
  let result = ds_hash_double_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_edge_min(s : DshashdoubleEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_edge_max(s : DshashdoubleEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_edge_to_string(s : DshashdoubleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoublePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_path_make(size : Int) -> DshashdoublePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_path_len(s : DshashdoublePath) -> Int { s.size }

pub fn ds_hash_double_path_get(s : DshashdoublePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_path_set(s : DshashdoublePath, i : Int, v : Double) -> DshashdoublePath {
  let result = ds_hash_double_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_path_sum(s : DshashdoublePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_double_path_mean(s : DshashdoublePath) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_double_path_sum(s) / s.size.to_double() }
}

pub fn ds_hash_double_path_scale(s : DshashdoublePath, f : Double) -> DshashdoublePath {
  let result = ds_hash_double_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_double_path_add(a : DshashdoublePath, b : DshashdoublePath) -> DshashdoublePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_double_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_double_path_copy(s : DshashdoublePath) -> DshashdoublePath {
  let result = ds_hash_double_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_double_path_fill(s : DshashdoublePath, v : Double) -> DshashdoublePath {
  let result = ds_hash_double_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_path_min(s : DshashdoublePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_path_max(s : DshashdoublePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_path_to_string(s : DshashdoublePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_cluster_make(size : Int) -> DshashdoubleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_cluster_len(s : DshashdoubleCluster) -> Int { s.size }

pub fn ds_hash_double_cluster_get(s : DshashdoubleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_cluster_set(s : DshashdoubleCluster, i : Int, v : Double) -> DshashdoubleCluster {
  let result = ds_hash_double_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_cluster_sum(s : DshashdoubleCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_double_cluster_mean(s : DshashdoubleCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_double_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_hash_double_cluster_scale(s : DshashdoubleCluster, f : Double) -> DshashdoubleCluster {
  let result = ds_hash_double_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_double_cluster_add(a : DshashdoubleCluster, b : DshashdoubleCluster) -> DshashdoubleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_double_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_double_cluster_copy(s : DshashdoubleCluster) -> DshashdoubleCluster {
  let result = ds_hash_double_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_double_cluster_fill(s : DshashdoubleCluster, v : Double) -> DshashdoubleCluster {
  let result = ds_hash_double_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_cluster_min(s : DshashdoubleCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_cluster_max(s : DshashdoubleCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_cluster_to_string(s : DshashdoubleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_model_make(size : Int) -> DshashdoubleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_model_len(s : DshashdoubleModel) -> Int { s.size }

pub fn ds_hash_double_model_get(s : DshashdoubleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_model_set(s : DshashdoubleModel, i : Int, v : Double) -> DshashdoubleModel {
  let result = ds_hash_double_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_model_sum(s : DshashdoubleModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_double_model_mean(s : DshashdoubleModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_double_model_sum(s) / s.size.to_double() }
}

pub fn ds_hash_double_model_scale(s : DshashdoubleModel, f : Double) -> DshashdoubleModel {
  let result = ds_hash_double_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_double_model_add(a : DshashdoubleModel, b : DshashdoubleModel) -> DshashdoubleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_double_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_double_model_copy(s : DshashdoubleModel) -> DshashdoubleModel {
  let result = ds_hash_double_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_double_model_fill(s : DshashdoubleModel, v : Double) -> DshashdoubleModel {
  let result = ds_hash_double_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_model_min(s : DshashdoubleModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_model_max(s : DshashdoubleModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_model_to_string(s : DshashdoubleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_layer_make(size : Int) -> DshashdoubleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_layer_len(s : DshashdoubleLayer) -> Int { s.size }

pub fn ds_hash_double_layer_get(s : DshashdoubleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_layer_set(s : DshashdoubleLayer, i : Int, v : Double) -> DshashdoubleLayer {
  let result = ds_hash_double_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_layer_sum(s : DshashdoubleLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_double_layer_mean(s : DshashdoubleLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_double_layer_sum(s) / s.size.to_double() }
}

pub fn ds_hash_double_layer_scale(s : DshashdoubleLayer, f : Double) -> DshashdoubleLayer {
  let result = ds_hash_double_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_double_layer_add(a : DshashdoubleLayer, b : DshashdoubleLayer) -> DshashdoubleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_double_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_double_layer_copy(s : DshashdoubleLayer) -> DshashdoubleLayer {
  let result = ds_hash_double_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_double_layer_fill(s : DshashdoubleLayer, v : Double) -> DshashdoubleLayer {
  let result = ds_hash_double_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_layer_min(s : DshashdoubleLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_layer_max(s : DshashdoubleLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_layer_to_string(s : DshashdoubleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_buffer_make(size : Int) -> DshashdoubleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_buffer_len(s : DshashdoubleBuffer) -> Int { s.size }

pub fn ds_hash_double_buffer_get(s : DshashdoubleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_buffer_set(s : DshashdoubleBuffer, i : Int, v : Double) -> DshashdoubleBuffer {
  let result = ds_hash_double_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_buffer_sum(s : DshashdoubleBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_double_buffer_mean(s : DshashdoubleBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_double_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_hash_double_buffer_scale(s : DshashdoubleBuffer, f : Double) -> DshashdoubleBuffer {
  let result = ds_hash_double_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_double_buffer_add(a : DshashdoubleBuffer, b : DshashdoubleBuffer) -> DshashdoubleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_double_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_double_buffer_copy(s : DshashdoubleBuffer) -> DshashdoubleBuffer {
  let result = ds_hash_double_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_double_buffer_fill(s : DshashdoubleBuffer, v : Double) -> DshashdoubleBuffer {
  let result = ds_hash_double_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_buffer_min(s : DshashdoubleBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_buffer_max(s : DshashdoubleBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_buffer_to_string(s : DshashdoubleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_cursor_make(size : Int) -> DshashdoubleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_cursor_len(s : DshashdoubleCursor) -> Int { s.size }

pub fn ds_hash_double_cursor_get(s : DshashdoubleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_cursor_set(s : DshashdoubleCursor, i : Int, v : Double) -> DshashdoubleCursor {
  let result = ds_hash_double_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_cursor_sum(s : DshashdoubleCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_double_cursor_mean(s : DshashdoubleCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_double_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_hash_double_cursor_scale(s : DshashdoubleCursor, f : Double) -> DshashdoubleCursor {
  let result = ds_hash_double_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_double_cursor_add(a : DshashdoubleCursor, b : DshashdoubleCursor) -> DshashdoubleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_double_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_double_cursor_copy(s : DshashdoubleCursor) -> DshashdoubleCursor {
  let result = ds_hash_double_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_double_cursor_fill(s : DshashdoubleCursor, v : Double) -> DshashdoubleCursor {
  let result = ds_hash_double_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_cursor_min(s : DshashdoubleCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_cursor_max(s : DshashdoubleCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_cursor_to_string(s : DshashdoubleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_view_make(size : Int) -> DshashdoubleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_view_len(s : DshashdoubleView) -> Int { s.size }

pub fn ds_hash_double_view_get(s : DshashdoubleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_view_set(s : DshashdoubleView, i : Int, v : Double) -> DshashdoubleView {
  let result = ds_hash_double_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_view_sum(s : DshashdoubleView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_double_view_mean(s : DshashdoubleView) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_double_view_sum(s) / s.size.to_double() }
}

pub fn ds_hash_double_view_scale(s : DshashdoubleView, f : Double) -> DshashdoubleView {
  let result = ds_hash_double_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_double_view_add(a : DshashdoubleView, b : DshashdoubleView) -> DshashdoubleView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_double_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_double_view_copy(s : DshashdoubleView) -> DshashdoubleView {
  let result = ds_hash_double_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_double_view_fill(s : DshashdoubleView, v : Double) -> DshashdoubleView {
  let result = ds_hash_double_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_view_min(s : DshashdoubleView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_view_max(s : DshashdoubleView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_view_to_string(s : DshashdoubleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_range_make(size : Int) -> DshashdoubleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_range_len(s : DshashdoubleRange) -> Int { s.size }

pub fn ds_hash_double_range_get(s : DshashdoubleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_range_set(s : DshashdoubleRange, i : Int, v : Double) -> DshashdoubleRange {
  let result = ds_hash_double_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_range_sum(s : DshashdoubleRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_double_range_mean(s : DshashdoubleRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_double_range_sum(s) / s.size.to_double() }
}

pub fn ds_hash_double_range_scale(s : DshashdoubleRange, f : Double) -> DshashdoubleRange {
  let result = ds_hash_double_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_double_range_add(a : DshashdoubleRange, b : DshashdoubleRange) -> DshashdoubleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_double_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_double_range_copy(s : DshashdoubleRange) -> DshashdoubleRange {
  let result = ds_hash_double_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_double_range_fill(s : DshashdoubleRange, v : Double) -> DshashdoubleRange {
  let result = ds_hash_double_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_range_min(s : DshashdoubleRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_range_max(s : DshashdoubleRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_range_to_string(s : DshashdoubleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_slice_make(size : Int) -> DshashdoubleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_slice_len(s : DshashdoubleSlice) -> Int { s.size }

pub fn ds_hash_double_slice_get(s : DshashdoubleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_slice_set(s : DshashdoubleSlice, i : Int, v : Double) -> DshashdoubleSlice {
  let result = ds_hash_double_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_slice_sum(s : DshashdoubleSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_double_slice_mean(s : DshashdoubleSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_double_slice_sum(s) / s.size.to_double() }
}

pub fn ds_hash_double_slice_scale(s : DshashdoubleSlice, f : Double) -> DshashdoubleSlice {
  let result = ds_hash_double_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_double_slice_add(a : DshashdoubleSlice, b : DshashdoubleSlice) -> DshashdoubleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_double_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_double_slice_copy(s : DshashdoubleSlice) -> DshashdoubleSlice {
  let result = ds_hash_double_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_double_slice_fill(s : DshashdoubleSlice, v : Double) -> DshashdoubleSlice {
  let result = ds_hash_double_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_double_slice_min(s : DshashdoubleSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_slice_max(s : DshashdoubleSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_double_slice_to_string(s : DshashdoubleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

