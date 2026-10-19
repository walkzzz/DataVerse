///===
/// extcore/ds_hash_open

pub(all) struct DshashopenPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_open_make_point(x : Double, y : Double) -> DshashopenPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_open_make_point3(x : Double, y : Double, z : Double) -> DshashopenPoint {
  { x, y, z, label: 0 }
}

pub fn ds_hash_open_point_x(pt : DshashopenPoint) -> Double { pt.x }

pub fn ds_hash_open_point_y(pt : DshashopenPoint) -> Double { pt.y }

pub fn ds_hash_open_point_z(pt : DshashopenPoint) -> Double { pt.z }

pub fn ds_hash_open_point_label(pt : DshashopenPoint) -> Int { pt.label }

pub fn ds_hash_open_point_dist(a : DshashopenPoint, b : DshashopenPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_hash_open_point_add(a : DshashopenPoint, b : DshashopenPoint) -> DshashopenPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_hash_open_point_sub(a : DshashopenPoint, b : DshashopenPoint) -> DshashopenPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_hash_open_point_scale(pt : DshashopenPoint, s : Double) -> DshashopenPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_hash_open_point_dot(a : DshashopenPoint, b : DshashopenPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_hash_open_point_cross(a : DshashopenPoint, b : DshashopenPoint) -> DshashopenPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_hash_open_point_norm(pt : DshashopenPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_hash_open_point_normalize(pt : DshashopenPoint) -> DshashopenPoint {
  let n = ds_hash_open_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_hash_open_point_scale(pt, 1.0 / n) }
}

pub fn ds_hash_open_point_negate(pt : DshashopenPoint) -> DshashopenPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_hash_open_point_mid(a : DshashopenPoint, b : DshashopenPoint) -> DshashopenPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_hash_open_point_lerp(a : DshashopenPoint, b : DshashopenPoint, t : Double) -> DshashopenPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_hash_open_point_to_string(pt : DshashopenPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DshashopenSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_open_make_series(vals : Array[Double], name : String) -> DshashopenSeries {
  { vals, name, meta: 0 }
}

pub fn ds_hash_open_series_len(s : DshashopenSeries) -> Int { s.vals.length() }

pub fn ds_hash_open_series_sum(s : DshashopenSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_hash_open_series_mean(s : DshashopenSeries) -> Double {
  let n = ds_hash_open_series_len(s)
  if n == 0 { 0.0 } else { ds_hash_open_series_sum(s) / n.to_double() }
}

pub fn ds_hash_open_series_min(s : DshashopenSeries) -> Double {
  let n = ds_hash_open_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_hash_open_series_max(s : DshashopenSeries) -> Double {
  let n = ds_hash_open_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_hash_open_series_range(s : DshashopenSeries) -> Double {
  ds_hash_open_series_max(s) - ds_hash_open_series_min(s)
}

pub fn ds_hash_open_series_var(s : DshashopenSeries) -> Double {
  let n = ds_hash_open_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_hash_open_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_hash_open_series_std(s : DshashopenSeries) -> Double { @_common.sqrt(ds_hash_open_series_var(s)) }

pub fn ds_hash_open_series_median(s : DshashopenSeries) -> Double {
  let n = ds_hash_open_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_hash_open_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_hash_open_series_scale(s : DshashopenSeries, f : Double) -> DshashopenSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_hash_open_series_add(a : DshashopenSeries, b : DshashopenSeries) -> DshashopenSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_hash_open_series_sub(a : DshashopenSeries, b : DshashopenSeries) -> DshashopenSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_hash_open_series_normalize(s : DshashopenSeries) -> DshashopenSeries {
  let mn = ds_hash_open_series_min(s)
  let mx = ds_hash_open_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_hash_open_series_cumsum(s : DshashopenSeries) -> DshashopenSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_hash_open_series_to_string(s : DshashopenSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashopenMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_open_make_matrix(rows : Int, cols : Int, val : Double) -> DshashopenMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_open_matrix_identity(n : Int) -> DshashopenMatrix {
  let m = ds_hash_open_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_hash_open_matrix_get(m : DshashopenMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_hash_open_matrix_transpose(m : DshashopenMatrix) -> DshashopenMatrix {
  let result = ds_hash_open_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_hash_open_matrix_add(a : DshashopenMatrix, b : DshashopenMatrix) -> DshashopenMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_hash_open_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_hash_open_matrix_scale(m : DshashopenMatrix, s : Double) -> DshashopenMatrix {
  let result = ds_hash_open_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_hash_open_matrix_multiply(a : DshashopenMatrix, b : DshashopenMatrix) -> DshashopenMatrix {
  if a.cols != b.rows { return ds_hash_open_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_hash_open_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_hash_open_matrix_trace(m : DshashopenMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_hash_open_matrix_det(m : DshashopenMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_hash_open_matrix_norm(m : DshashopenMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_hash_open_matrix_to_string(m : DshashopenMatrix) -> String {
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

pub(all) struct DshashopenVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_open_make_vector(comps : Array[Double]) -> DshashopenVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_open_vector_zero(dim : Int) -> DshashopenVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_hash_open_vector_add(a : DshashopenVector, b : DshashopenVector) -> DshashopenVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_open_vector_sub(a : DshashopenVector, b : DshashopenVector) -> DshashopenVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_open_vector_scale(v : DshashopenVector, s : Double) -> DshashopenVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_hash_open_vector_dot(a : DshashopenVector, b : DshashopenVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_hash_open_vector_norm(v : DshashopenVector) -> Double { @_common.sqrt(ds_hash_open_vector_dot(v, v)) }

pub fn ds_hash_open_vector_normalize(v : DshashopenVector) -> DshashopenVector {
  let n = ds_hash_open_vector_norm(v)
  if n < 0.0000001 { v } else { ds_hash_open_vector_scale(v, 1.0 / n) }
}

pub fn ds_hash_open_vector_dist(a : DshashopenVector, b : DshashopenVector) -> Double {
  ds_hash_open_vector_norm(ds_hash_open_vector_sub(a, b))
}

pub fn ds_hash_open_vector_to_string(v : DshashopenVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_open_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_hash_open_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_hash_open_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_hash_open_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_hash_open_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_hash_open_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_hash_open_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_hash_open_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_hash_open_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_hash_open_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_hash_open_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_hash_open_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_hash_open_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_hash_open_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_hash_open_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_hash_open_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_hash_open_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_hash_open_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_hash_open_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_hash_open_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_hash_open_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_hash_open_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_hash_open_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_hash_open_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_hash_open_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_hash_open_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_hash_open_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_hash_open_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_hash_open_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DshashopenFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_frame_make(size : Int) -> DshashopenFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_frame_len(s : DshashopenFrame) -> Int { s.size }

pub fn ds_hash_open_frame_get(s : DshashopenFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_frame_set(s : DshashopenFrame, i : Int, v : Double) -> DshashopenFrame {
  let result = ds_hash_open_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_frame_sum(s : DshashopenFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_open_frame_mean(s : DshashopenFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_open_frame_sum(s) / s.size.to_double() }
}

pub fn ds_hash_open_frame_scale(s : DshashopenFrame, f : Double) -> DshashopenFrame {
  let result = ds_hash_open_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_open_frame_add(a : DshashopenFrame, b : DshashopenFrame) -> DshashopenFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_open_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_open_frame_copy(s : DshashopenFrame) -> DshashopenFrame {
  let result = ds_hash_open_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_open_frame_fill(s : DshashopenFrame, v : Double) -> DshashopenFrame {
  let result = ds_hash_open_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_frame_min(s : DshashopenFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_frame_max(s : DshashopenFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_frame_to_string(s : DshashopenFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_table_make(size : Int) -> DshashopenTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_table_len(s : DshashopenTable) -> Int { s.size }

pub fn ds_hash_open_table_get(s : DshashopenTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_table_set(s : DshashopenTable, i : Int, v : Double) -> DshashopenTable {
  let result = ds_hash_open_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_table_sum(s : DshashopenTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_open_table_mean(s : DshashopenTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_open_table_sum(s) / s.size.to_double() }
}

pub fn ds_hash_open_table_scale(s : DshashopenTable, f : Double) -> DshashopenTable {
  let result = ds_hash_open_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_open_table_add(a : DshashopenTable, b : DshashopenTable) -> DshashopenTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_open_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_open_table_copy(s : DshashopenTable) -> DshashopenTable {
  let result = ds_hash_open_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_open_table_fill(s : DshashopenTable, v : Double) -> DshashopenTable {
  let result = ds_hash_open_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_table_min(s : DshashopenTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_table_max(s : DshashopenTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_table_to_string(s : DshashopenTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_graphn_make(size : Int) -> DshashopenGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_graphn_len(s : DshashopenGraphN) -> Int { s.size }

pub fn ds_hash_open_graphn_get(s : DshashopenGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_graphn_set(s : DshashopenGraphN, i : Int, v : Double) -> DshashopenGraphN {
  let result = ds_hash_open_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_graphn_sum(s : DshashopenGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_open_graphn_mean(s : DshashopenGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_open_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_hash_open_graphn_scale(s : DshashopenGraphN, f : Double) -> DshashopenGraphN {
  let result = ds_hash_open_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_open_graphn_add(a : DshashopenGraphN, b : DshashopenGraphN) -> DshashopenGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_open_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_open_graphn_copy(s : DshashopenGraphN) -> DshashopenGraphN {
  let result = ds_hash_open_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_open_graphn_fill(s : DshashopenGraphN, v : Double) -> DshashopenGraphN {
  let result = ds_hash_open_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_graphn_min(s : DshashopenGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_graphn_max(s : DshashopenGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_graphn_to_string(s : DshashopenGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_node_make(size : Int) -> DshashopenNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_node_len(s : DshashopenNode) -> Int { s.size }

pub fn ds_hash_open_node_get(s : DshashopenNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_node_set(s : DshashopenNode, i : Int, v : Double) -> DshashopenNode {
  let result = ds_hash_open_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_node_sum(s : DshashopenNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_open_node_mean(s : DshashopenNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_open_node_sum(s) / s.size.to_double() }
}

pub fn ds_hash_open_node_scale(s : DshashopenNode, f : Double) -> DshashopenNode {
  let result = ds_hash_open_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_open_node_add(a : DshashopenNode, b : DshashopenNode) -> DshashopenNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_open_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_open_node_copy(s : DshashopenNode) -> DshashopenNode {
  let result = ds_hash_open_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_open_node_fill(s : DshashopenNode, v : Double) -> DshashopenNode {
  let result = ds_hash_open_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_node_min(s : DshashopenNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_node_max(s : DshashopenNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_node_to_string(s : DshashopenNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_edge_make(size : Int) -> DshashopenEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_edge_len(s : DshashopenEdge) -> Int { s.size }

pub fn ds_hash_open_edge_get(s : DshashopenEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_edge_set(s : DshashopenEdge, i : Int, v : Double) -> DshashopenEdge {
  let result = ds_hash_open_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_edge_sum(s : DshashopenEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_open_edge_mean(s : DshashopenEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_open_edge_sum(s) / s.size.to_double() }
}

pub fn ds_hash_open_edge_scale(s : DshashopenEdge, f : Double) -> DshashopenEdge {
  let result = ds_hash_open_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_open_edge_add(a : DshashopenEdge, b : DshashopenEdge) -> DshashopenEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_open_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_open_edge_copy(s : DshashopenEdge) -> DshashopenEdge {
  let result = ds_hash_open_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_open_edge_fill(s : DshashopenEdge, v : Double) -> DshashopenEdge {
  let result = ds_hash_open_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_edge_min(s : DshashopenEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_edge_max(s : DshashopenEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_edge_to_string(s : DshashopenEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_path_make(size : Int) -> DshashopenPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_path_len(s : DshashopenPath) -> Int { s.size }

pub fn ds_hash_open_path_get(s : DshashopenPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_path_set(s : DshashopenPath, i : Int, v : Double) -> DshashopenPath {
  let result = ds_hash_open_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_path_sum(s : DshashopenPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_open_path_mean(s : DshashopenPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_open_path_sum(s) / s.size.to_double() }
}

pub fn ds_hash_open_path_scale(s : DshashopenPath, f : Double) -> DshashopenPath {
  let result = ds_hash_open_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_open_path_add(a : DshashopenPath, b : DshashopenPath) -> DshashopenPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_open_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_open_path_copy(s : DshashopenPath) -> DshashopenPath {
  let result = ds_hash_open_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_open_path_fill(s : DshashopenPath, v : Double) -> DshashopenPath {
  let result = ds_hash_open_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_path_min(s : DshashopenPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_path_max(s : DshashopenPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_path_to_string(s : DshashopenPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_cluster_make(size : Int) -> DshashopenCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_cluster_len(s : DshashopenCluster) -> Int { s.size }

pub fn ds_hash_open_cluster_get(s : DshashopenCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_cluster_set(s : DshashopenCluster, i : Int, v : Double) -> DshashopenCluster {
  let result = ds_hash_open_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_cluster_sum(s : DshashopenCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_open_cluster_mean(s : DshashopenCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_open_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_hash_open_cluster_scale(s : DshashopenCluster, f : Double) -> DshashopenCluster {
  let result = ds_hash_open_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_open_cluster_add(a : DshashopenCluster, b : DshashopenCluster) -> DshashopenCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_open_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_open_cluster_copy(s : DshashopenCluster) -> DshashopenCluster {
  let result = ds_hash_open_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_open_cluster_fill(s : DshashopenCluster, v : Double) -> DshashopenCluster {
  let result = ds_hash_open_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_cluster_min(s : DshashopenCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_cluster_max(s : DshashopenCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_cluster_to_string(s : DshashopenCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_model_make(size : Int) -> DshashopenModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_model_len(s : DshashopenModel) -> Int { s.size }

pub fn ds_hash_open_model_get(s : DshashopenModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_model_set(s : DshashopenModel, i : Int, v : Double) -> DshashopenModel {
  let result = ds_hash_open_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_model_sum(s : DshashopenModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_open_model_mean(s : DshashopenModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_open_model_sum(s) / s.size.to_double() }
}

pub fn ds_hash_open_model_scale(s : DshashopenModel, f : Double) -> DshashopenModel {
  let result = ds_hash_open_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_open_model_add(a : DshashopenModel, b : DshashopenModel) -> DshashopenModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_open_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_open_model_copy(s : DshashopenModel) -> DshashopenModel {
  let result = ds_hash_open_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_open_model_fill(s : DshashopenModel, v : Double) -> DshashopenModel {
  let result = ds_hash_open_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_model_min(s : DshashopenModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_model_max(s : DshashopenModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_model_to_string(s : DshashopenModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_layer_make(size : Int) -> DshashopenLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_layer_len(s : DshashopenLayer) -> Int { s.size }

pub fn ds_hash_open_layer_get(s : DshashopenLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_layer_set(s : DshashopenLayer, i : Int, v : Double) -> DshashopenLayer {
  let result = ds_hash_open_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_layer_sum(s : DshashopenLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_open_layer_mean(s : DshashopenLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_open_layer_sum(s) / s.size.to_double() }
}

pub fn ds_hash_open_layer_scale(s : DshashopenLayer, f : Double) -> DshashopenLayer {
  let result = ds_hash_open_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_open_layer_add(a : DshashopenLayer, b : DshashopenLayer) -> DshashopenLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_open_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_open_layer_copy(s : DshashopenLayer) -> DshashopenLayer {
  let result = ds_hash_open_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_open_layer_fill(s : DshashopenLayer, v : Double) -> DshashopenLayer {
  let result = ds_hash_open_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_layer_min(s : DshashopenLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_layer_max(s : DshashopenLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_layer_to_string(s : DshashopenLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_buffer_make(size : Int) -> DshashopenBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_buffer_len(s : DshashopenBuffer) -> Int { s.size }

pub fn ds_hash_open_buffer_get(s : DshashopenBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_buffer_set(s : DshashopenBuffer, i : Int, v : Double) -> DshashopenBuffer {
  let result = ds_hash_open_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_buffer_sum(s : DshashopenBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_open_buffer_mean(s : DshashopenBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_open_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_hash_open_buffer_scale(s : DshashopenBuffer, f : Double) -> DshashopenBuffer {
  let result = ds_hash_open_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_open_buffer_add(a : DshashopenBuffer, b : DshashopenBuffer) -> DshashopenBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_open_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_open_buffer_copy(s : DshashopenBuffer) -> DshashopenBuffer {
  let result = ds_hash_open_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_open_buffer_fill(s : DshashopenBuffer, v : Double) -> DshashopenBuffer {
  let result = ds_hash_open_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_buffer_min(s : DshashopenBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_buffer_max(s : DshashopenBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_buffer_to_string(s : DshashopenBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_cursor_make(size : Int) -> DshashopenCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_cursor_len(s : DshashopenCursor) -> Int { s.size }

pub fn ds_hash_open_cursor_get(s : DshashopenCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_cursor_set(s : DshashopenCursor, i : Int, v : Double) -> DshashopenCursor {
  let result = ds_hash_open_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_cursor_sum(s : DshashopenCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_open_cursor_mean(s : DshashopenCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_open_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_hash_open_cursor_scale(s : DshashopenCursor, f : Double) -> DshashopenCursor {
  let result = ds_hash_open_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_open_cursor_add(a : DshashopenCursor, b : DshashopenCursor) -> DshashopenCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_open_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_open_cursor_copy(s : DshashopenCursor) -> DshashopenCursor {
  let result = ds_hash_open_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_open_cursor_fill(s : DshashopenCursor, v : Double) -> DshashopenCursor {
  let result = ds_hash_open_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_cursor_min(s : DshashopenCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_cursor_max(s : DshashopenCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_cursor_to_string(s : DshashopenCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_view_make(size : Int) -> DshashopenView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_view_len(s : DshashopenView) -> Int { s.size }

pub fn ds_hash_open_view_get(s : DshashopenView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_view_set(s : DshashopenView, i : Int, v : Double) -> DshashopenView {
  let result = ds_hash_open_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_view_sum(s : DshashopenView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_open_view_mean(s : DshashopenView) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_open_view_sum(s) / s.size.to_double() }
}

pub fn ds_hash_open_view_scale(s : DshashopenView, f : Double) -> DshashopenView {
  let result = ds_hash_open_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_open_view_add(a : DshashopenView, b : DshashopenView) -> DshashopenView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_open_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_open_view_copy(s : DshashopenView) -> DshashopenView {
  let result = ds_hash_open_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_open_view_fill(s : DshashopenView, v : Double) -> DshashopenView {
  let result = ds_hash_open_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_view_min(s : DshashopenView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_view_max(s : DshashopenView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_view_to_string(s : DshashopenView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_range_make(size : Int) -> DshashopenRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_range_len(s : DshashopenRange) -> Int { s.size }

pub fn ds_hash_open_range_get(s : DshashopenRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_range_set(s : DshashopenRange, i : Int, v : Double) -> DshashopenRange {
  let result = ds_hash_open_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_range_sum(s : DshashopenRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_open_range_mean(s : DshashopenRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_open_range_sum(s) / s.size.to_double() }
}

pub fn ds_hash_open_range_scale(s : DshashopenRange, f : Double) -> DshashopenRange {
  let result = ds_hash_open_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_open_range_add(a : DshashopenRange, b : DshashopenRange) -> DshashopenRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_open_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_open_range_copy(s : DshashopenRange) -> DshashopenRange {
  let result = ds_hash_open_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_open_range_fill(s : DshashopenRange, v : Double) -> DshashopenRange {
  let result = ds_hash_open_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_range_min(s : DshashopenRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_range_max(s : DshashopenRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_range_to_string(s : DshashopenRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_slice_make(size : Int) -> DshashopenSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_slice_len(s : DshashopenSlice) -> Int { s.size }

pub fn ds_hash_open_slice_get(s : DshashopenSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_slice_set(s : DshashopenSlice, i : Int, v : Double) -> DshashopenSlice {
  let result = ds_hash_open_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_slice_sum(s : DshashopenSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_open_slice_mean(s : DshashopenSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_open_slice_sum(s) / s.size.to_double() }
}

pub fn ds_hash_open_slice_scale(s : DshashopenSlice, f : Double) -> DshashopenSlice {
  let result = ds_hash_open_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_open_slice_add(a : DshashopenSlice, b : DshashopenSlice) -> DshashopenSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_open_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_open_slice_copy(s : DshashopenSlice) -> DshashopenSlice {
  let result = ds_hash_open_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_open_slice_fill(s : DshashopenSlice, v : Double) -> DshashopenSlice {
  let result = ds_hash_open_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_open_slice_min(s : DshashopenSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_slice_max(s : DshashopenSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_open_slice_to_string(s : DshashopenSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

