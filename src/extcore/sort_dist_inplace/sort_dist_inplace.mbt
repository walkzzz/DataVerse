///===
/// extcore/sort_dist_inplace

pub(all) struct SortdistinplacePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_inplace_make_point(x : Double, y : Double) -> SortdistinplacePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_inplace_make_point3(x : Double, y : Double, z : Double) -> SortdistinplacePoint {
  { x, y, z, label: 0 }
}

pub fn sort_dist_inplace_point_x(pt : SortdistinplacePoint) -> Double { pt.x }

pub fn sort_dist_inplace_point_y(pt : SortdistinplacePoint) -> Double { pt.y }

pub fn sort_dist_inplace_point_z(pt : SortdistinplacePoint) -> Double { pt.z }

pub fn sort_dist_inplace_point_label(pt : SortdistinplacePoint) -> Int { pt.label }

pub fn sort_dist_inplace_point_dist(a : SortdistinplacePoint, b : SortdistinplacePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_dist_inplace_point_add(a : SortdistinplacePoint, b : SortdistinplacePoint) -> SortdistinplacePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_dist_inplace_point_sub(a : SortdistinplacePoint, b : SortdistinplacePoint) -> SortdistinplacePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_dist_inplace_point_scale(pt : SortdistinplacePoint, s : Double) -> SortdistinplacePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_dist_inplace_point_dot(a : SortdistinplacePoint, b : SortdistinplacePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_dist_inplace_point_cross(a : SortdistinplacePoint, b : SortdistinplacePoint) -> SortdistinplacePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_dist_inplace_point_norm(pt : SortdistinplacePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_dist_inplace_point_normalize(pt : SortdistinplacePoint) -> SortdistinplacePoint {
  let n = sort_dist_inplace_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_dist_inplace_point_scale(pt, 1.0 / n) }
}

pub fn sort_dist_inplace_point_negate(pt : SortdistinplacePoint) -> SortdistinplacePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_dist_inplace_point_mid(a : SortdistinplacePoint, b : SortdistinplacePoint) -> SortdistinplacePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_dist_inplace_point_lerp(a : SortdistinplacePoint, b : SortdistinplacePoint, t : Double) -> SortdistinplacePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_dist_inplace_point_to_string(pt : SortdistinplacePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortdistinplaceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_inplace_make_series(vals : Array[Double], name : String) -> SortdistinplaceSeries {
  { vals, name, meta: 0 }
}

pub fn sort_dist_inplace_series_len(s : SortdistinplaceSeries) -> Int { s.vals.length() }

pub fn sort_dist_inplace_series_sum(s : SortdistinplaceSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_dist_inplace_series_mean(s : SortdistinplaceSeries) -> Double {
  let n = sort_dist_inplace_series_len(s)
  if n == 0 { 0.0 } else { sort_dist_inplace_series_sum(s) / n.to_double() }
}

pub fn sort_dist_inplace_series_min(s : SortdistinplaceSeries) -> Double {
  let n = sort_dist_inplace_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_dist_inplace_series_max(s : SortdistinplaceSeries) -> Double {
  let n = sort_dist_inplace_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_dist_inplace_series_range(s : SortdistinplaceSeries) -> Double {
  sort_dist_inplace_series_max(s) - sort_dist_inplace_series_min(s)
}

pub fn sort_dist_inplace_series_var(s : SortdistinplaceSeries) -> Double {
  let n = sort_dist_inplace_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_dist_inplace_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_dist_inplace_series_std(s : SortdistinplaceSeries) -> Double { @_common.sqrt(sort_dist_inplace_series_var(s)) }

pub fn sort_dist_inplace_series_median(s : SortdistinplaceSeries) -> Double {
  let n = sort_dist_inplace_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_dist_inplace_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_dist_inplace_series_scale(s : SortdistinplaceSeries, f : Double) -> SortdistinplaceSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_dist_inplace_series_add(a : SortdistinplaceSeries, b : SortdistinplaceSeries) -> SortdistinplaceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_dist_inplace_series_sub(a : SortdistinplaceSeries, b : SortdistinplaceSeries) -> SortdistinplaceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_dist_inplace_series_normalize(s : SortdistinplaceSeries) -> SortdistinplaceSeries {
  let mn = sort_dist_inplace_series_min(s)
  let mx = sort_dist_inplace_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_dist_inplace_series_cumsum(s : SortdistinplaceSeries) -> SortdistinplaceSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_dist_inplace_series_to_string(s : SortdistinplaceSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistinplaceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_inplace_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistinplaceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_inplace_matrix_identity(n : Int) -> SortdistinplaceMatrix {
  let m = sort_dist_inplace_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_dist_inplace_matrix_get(m : SortdistinplaceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_dist_inplace_matrix_transpose(m : SortdistinplaceMatrix) -> SortdistinplaceMatrix {
  let result = sort_dist_inplace_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_dist_inplace_matrix_add(a : SortdistinplaceMatrix, b : SortdistinplaceMatrix) -> SortdistinplaceMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_dist_inplace_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_dist_inplace_matrix_scale(m : SortdistinplaceMatrix, s : Double) -> SortdistinplaceMatrix {
  let result = sort_dist_inplace_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_dist_inplace_matrix_multiply(a : SortdistinplaceMatrix, b : SortdistinplaceMatrix) -> SortdistinplaceMatrix {
  if a.cols != b.rows { return sort_dist_inplace_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_dist_inplace_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_dist_inplace_matrix_trace(m : SortdistinplaceMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_dist_inplace_matrix_det(m : SortdistinplaceMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_dist_inplace_matrix_norm(m : SortdistinplaceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_dist_inplace_matrix_to_string(m : SortdistinplaceMatrix) -> String {
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

pub(all) struct SortdistinplaceVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_inplace_make_vector(comps : Array[Double]) -> SortdistinplaceVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_inplace_vector_zero(dim : Int) -> SortdistinplaceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_dist_inplace_vector_add(a : SortdistinplaceVector, b : SortdistinplaceVector) -> SortdistinplaceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_dist_inplace_vector_sub(a : SortdistinplaceVector, b : SortdistinplaceVector) -> SortdistinplaceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_dist_inplace_vector_scale(v : SortdistinplaceVector, s : Double) -> SortdistinplaceVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_dist_inplace_vector_dot(a : SortdistinplaceVector, b : SortdistinplaceVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_dist_inplace_vector_norm(v : SortdistinplaceVector) -> Double { @_common.sqrt(sort_dist_inplace_vector_dot(v, v)) }

pub fn sort_dist_inplace_vector_normalize(v : SortdistinplaceVector) -> SortdistinplaceVector {
  let n = sort_dist_inplace_vector_norm(v)
  if n < 0.0000001 { v } else { sort_dist_inplace_vector_scale(v, 1.0 / n) }
}

pub fn sort_dist_inplace_vector_dist(a : SortdistinplaceVector, b : SortdistinplaceVector) -> Double {
  sort_dist_inplace_vector_norm(sort_dist_inplace_vector_sub(a, b))
}

pub fn sort_dist_inplace_vector_to_string(v : SortdistinplaceVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_inplace_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_dist_inplace_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_dist_inplace_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_dist_inplace_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_dist_inplace_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_dist_inplace_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_dist_inplace_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_dist_inplace_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_dist_inplace_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_dist_inplace_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_dist_inplace_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_dist_inplace_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_dist_inplace_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_dist_inplace_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_dist_inplace_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_dist_inplace_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_dist_inplace_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_dist_inplace_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_dist_inplace_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_dist_inplace_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_dist_inplace_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_dist_inplace_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_dist_inplace_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_dist_inplace_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_dist_inplace_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_dist_inplace_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_dist_inplace_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_dist_inplace_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_dist_inplace_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortdistinplaceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_frame_make(size : Int) -> SortdistinplaceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_frame_len(s : SortdistinplaceFrame) -> Int { s.size }

pub fn sort_dist_inplace_frame_get(s : SortdistinplaceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_frame_set(s : SortdistinplaceFrame, i : Int, v : Double) -> SortdistinplaceFrame {
  let result = sort_dist_inplace_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_frame_sum(s : SortdistinplaceFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_inplace_frame_mean(s : SortdistinplaceFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_inplace_frame_sum(s) / s.size.to_double() }
}

pub fn sort_dist_inplace_frame_scale(s : SortdistinplaceFrame, f : Double) -> SortdistinplaceFrame {
  let result = sort_dist_inplace_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_inplace_frame_add(a : SortdistinplaceFrame, b : SortdistinplaceFrame) -> SortdistinplaceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_inplace_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_inplace_frame_copy(s : SortdistinplaceFrame) -> SortdistinplaceFrame {
  let result = sort_dist_inplace_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_inplace_frame_fill(s : SortdistinplaceFrame, v : Double) -> SortdistinplaceFrame {
  let result = sort_dist_inplace_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_frame_min(s : SortdistinplaceFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_frame_max(s : SortdistinplaceFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_frame_to_string(s : SortdistinplaceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_table_make(size : Int) -> SortdistinplaceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_table_len(s : SortdistinplaceTable) -> Int { s.size }

pub fn sort_dist_inplace_table_get(s : SortdistinplaceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_table_set(s : SortdistinplaceTable, i : Int, v : Double) -> SortdistinplaceTable {
  let result = sort_dist_inplace_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_table_sum(s : SortdistinplaceTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_inplace_table_mean(s : SortdistinplaceTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_inplace_table_sum(s) / s.size.to_double() }
}

pub fn sort_dist_inplace_table_scale(s : SortdistinplaceTable, f : Double) -> SortdistinplaceTable {
  let result = sort_dist_inplace_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_inplace_table_add(a : SortdistinplaceTable, b : SortdistinplaceTable) -> SortdistinplaceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_inplace_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_inplace_table_copy(s : SortdistinplaceTable) -> SortdistinplaceTable {
  let result = sort_dist_inplace_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_inplace_table_fill(s : SortdistinplaceTable, v : Double) -> SortdistinplaceTable {
  let result = sort_dist_inplace_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_table_min(s : SortdistinplaceTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_table_max(s : SortdistinplaceTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_table_to_string(s : SortdistinplaceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_graphn_make(size : Int) -> SortdistinplaceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_graphn_len(s : SortdistinplaceGraphN) -> Int { s.size }

pub fn sort_dist_inplace_graphn_get(s : SortdistinplaceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_graphn_set(s : SortdistinplaceGraphN, i : Int, v : Double) -> SortdistinplaceGraphN {
  let result = sort_dist_inplace_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_graphn_sum(s : SortdistinplaceGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_inplace_graphn_mean(s : SortdistinplaceGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_inplace_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_dist_inplace_graphn_scale(s : SortdistinplaceGraphN, f : Double) -> SortdistinplaceGraphN {
  let result = sort_dist_inplace_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_inplace_graphn_add(a : SortdistinplaceGraphN, b : SortdistinplaceGraphN) -> SortdistinplaceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_inplace_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_inplace_graphn_copy(s : SortdistinplaceGraphN) -> SortdistinplaceGraphN {
  let result = sort_dist_inplace_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_inplace_graphn_fill(s : SortdistinplaceGraphN, v : Double) -> SortdistinplaceGraphN {
  let result = sort_dist_inplace_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_graphn_min(s : SortdistinplaceGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_graphn_max(s : SortdistinplaceGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_graphn_to_string(s : SortdistinplaceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_node_make(size : Int) -> SortdistinplaceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_node_len(s : SortdistinplaceNode) -> Int { s.size }

pub fn sort_dist_inplace_node_get(s : SortdistinplaceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_node_set(s : SortdistinplaceNode, i : Int, v : Double) -> SortdistinplaceNode {
  let result = sort_dist_inplace_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_node_sum(s : SortdistinplaceNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_inplace_node_mean(s : SortdistinplaceNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_inplace_node_sum(s) / s.size.to_double() }
}

pub fn sort_dist_inplace_node_scale(s : SortdistinplaceNode, f : Double) -> SortdistinplaceNode {
  let result = sort_dist_inplace_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_inplace_node_add(a : SortdistinplaceNode, b : SortdistinplaceNode) -> SortdistinplaceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_inplace_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_inplace_node_copy(s : SortdistinplaceNode) -> SortdistinplaceNode {
  let result = sort_dist_inplace_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_inplace_node_fill(s : SortdistinplaceNode, v : Double) -> SortdistinplaceNode {
  let result = sort_dist_inplace_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_node_min(s : SortdistinplaceNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_node_max(s : SortdistinplaceNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_node_to_string(s : SortdistinplaceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_edge_make(size : Int) -> SortdistinplaceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_edge_len(s : SortdistinplaceEdge) -> Int { s.size }

pub fn sort_dist_inplace_edge_get(s : SortdistinplaceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_edge_set(s : SortdistinplaceEdge, i : Int, v : Double) -> SortdistinplaceEdge {
  let result = sort_dist_inplace_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_edge_sum(s : SortdistinplaceEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_inplace_edge_mean(s : SortdistinplaceEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_inplace_edge_sum(s) / s.size.to_double() }
}

pub fn sort_dist_inplace_edge_scale(s : SortdistinplaceEdge, f : Double) -> SortdistinplaceEdge {
  let result = sort_dist_inplace_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_inplace_edge_add(a : SortdistinplaceEdge, b : SortdistinplaceEdge) -> SortdistinplaceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_inplace_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_inplace_edge_copy(s : SortdistinplaceEdge) -> SortdistinplaceEdge {
  let result = sort_dist_inplace_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_inplace_edge_fill(s : SortdistinplaceEdge, v : Double) -> SortdistinplaceEdge {
  let result = sort_dist_inplace_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_edge_min(s : SortdistinplaceEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_edge_max(s : SortdistinplaceEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_edge_to_string(s : SortdistinplaceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplacePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_path_make(size : Int) -> SortdistinplacePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_path_len(s : SortdistinplacePath) -> Int { s.size }

pub fn sort_dist_inplace_path_get(s : SortdistinplacePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_path_set(s : SortdistinplacePath, i : Int, v : Double) -> SortdistinplacePath {
  let result = sort_dist_inplace_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_path_sum(s : SortdistinplacePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_inplace_path_mean(s : SortdistinplacePath) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_inplace_path_sum(s) / s.size.to_double() }
}

pub fn sort_dist_inplace_path_scale(s : SortdistinplacePath, f : Double) -> SortdistinplacePath {
  let result = sort_dist_inplace_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_inplace_path_add(a : SortdistinplacePath, b : SortdistinplacePath) -> SortdistinplacePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_inplace_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_inplace_path_copy(s : SortdistinplacePath) -> SortdistinplacePath {
  let result = sort_dist_inplace_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_inplace_path_fill(s : SortdistinplacePath, v : Double) -> SortdistinplacePath {
  let result = sort_dist_inplace_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_path_min(s : SortdistinplacePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_path_max(s : SortdistinplacePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_path_to_string(s : SortdistinplacePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_cluster_make(size : Int) -> SortdistinplaceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_cluster_len(s : SortdistinplaceCluster) -> Int { s.size }

pub fn sort_dist_inplace_cluster_get(s : SortdistinplaceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_cluster_set(s : SortdistinplaceCluster, i : Int, v : Double) -> SortdistinplaceCluster {
  let result = sort_dist_inplace_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_cluster_sum(s : SortdistinplaceCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_inplace_cluster_mean(s : SortdistinplaceCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_inplace_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_dist_inplace_cluster_scale(s : SortdistinplaceCluster, f : Double) -> SortdistinplaceCluster {
  let result = sort_dist_inplace_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_inplace_cluster_add(a : SortdistinplaceCluster, b : SortdistinplaceCluster) -> SortdistinplaceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_inplace_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_inplace_cluster_copy(s : SortdistinplaceCluster) -> SortdistinplaceCluster {
  let result = sort_dist_inplace_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_inplace_cluster_fill(s : SortdistinplaceCluster, v : Double) -> SortdistinplaceCluster {
  let result = sort_dist_inplace_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_cluster_min(s : SortdistinplaceCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_cluster_max(s : SortdistinplaceCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_cluster_to_string(s : SortdistinplaceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_model_make(size : Int) -> SortdistinplaceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_model_len(s : SortdistinplaceModel) -> Int { s.size }

pub fn sort_dist_inplace_model_get(s : SortdistinplaceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_model_set(s : SortdistinplaceModel, i : Int, v : Double) -> SortdistinplaceModel {
  let result = sort_dist_inplace_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_model_sum(s : SortdistinplaceModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_inplace_model_mean(s : SortdistinplaceModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_inplace_model_sum(s) / s.size.to_double() }
}

pub fn sort_dist_inplace_model_scale(s : SortdistinplaceModel, f : Double) -> SortdistinplaceModel {
  let result = sort_dist_inplace_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_inplace_model_add(a : SortdistinplaceModel, b : SortdistinplaceModel) -> SortdistinplaceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_inplace_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_inplace_model_copy(s : SortdistinplaceModel) -> SortdistinplaceModel {
  let result = sort_dist_inplace_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_inplace_model_fill(s : SortdistinplaceModel, v : Double) -> SortdistinplaceModel {
  let result = sort_dist_inplace_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_model_min(s : SortdistinplaceModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_model_max(s : SortdistinplaceModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_model_to_string(s : SortdistinplaceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_layer_make(size : Int) -> SortdistinplaceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_layer_len(s : SortdistinplaceLayer) -> Int { s.size }

pub fn sort_dist_inplace_layer_get(s : SortdistinplaceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_layer_set(s : SortdistinplaceLayer, i : Int, v : Double) -> SortdistinplaceLayer {
  let result = sort_dist_inplace_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_layer_sum(s : SortdistinplaceLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_inplace_layer_mean(s : SortdistinplaceLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_inplace_layer_sum(s) / s.size.to_double() }
}

pub fn sort_dist_inplace_layer_scale(s : SortdistinplaceLayer, f : Double) -> SortdistinplaceLayer {
  let result = sort_dist_inplace_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_inplace_layer_add(a : SortdistinplaceLayer, b : SortdistinplaceLayer) -> SortdistinplaceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_inplace_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_inplace_layer_copy(s : SortdistinplaceLayer) -> SortdistinplaceLayer {
  let result = sort_dist_inplace_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_inplace_layer_fill(s : SortdistinplaceLayer, v : Double) -> SortdistinplaceLayer {
  let result = sort_dist_inplace_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_layer_min(s : SortdistinplaceLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_layer_max(s : SortdistinplaceLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_layer_to_string(s : SortdistinplaceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_buffer_make(size : Int) -> SortdistinplaceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_buffer_len(s : SortdistinplaceBuffer) -> Int { s.size }

pub fn sort_dist_inplace_buffer_get(s : SortdistinplaceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_buffer_set(s : SortdistinplaceBuffer, i : Int, v : Double) -> SortdistinplaceBuffer {
  let result = sort_dist_inplace_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_buffer_sum(s : SortdistinplaceBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_inplace_buffer_mean(s : SortdistinplaceBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_inplace_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_dist_inplace_buffer_scale(s : SortdistinplaceBuffer, f : Double) -> SortdistinplaceBuffer {
  let result = sort_dist_inplace_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_inplace_buffer_add(a : SortdistinplaceBuffer, b : SortdistinplaceBuffer) -> SortdistinplaceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_inplace_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_inplace_buffer_copy(s : SortdistinplaceBuffer) -> SortdistinplaceBuffer {
  let result = sort_dist_inplace_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_inplace_buffer_fill(s : SortdistinplaceBuffer, v : Double) -> SortdistinplaceBuffer {
  let result = sort_dist_inplace_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_buffer_min(s : SortdistinplaceBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_buffer_max(s : SortdistinplaceBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_buffer_to_string(s : SortdistinplaceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_cursor_make(size : Int) -> SortdistinplaceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_cursor_len(s : SortdistinplaceCursor) -> Int { s.size }

pub fn sort_dist_inplace_cursor_get(s : SortdistinplaceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_cursor_set(s : SortdistinplaceCursor, i : Int, v : Double) -> SortdistinplaceCursor {
  let result = sort_dist_inplace_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_cursor_sum(s : SortdistinplaceCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_inplace_cursor_mean(s : SortdistinplaceCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_inplace_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_dist_inplace_cursor_scale(s : SortdistinplaceCursor, f : Double) -> SortdistinplaceCursor {
  let result = sort_dist_inplace_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_inplace_cursor_add(a : SortdistinplaceCursor, b : SortdistinplaceCursor) -> SortdistinplaceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_inplace_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_inplace_cursor_copy(s : SortdistinplaceCursor) -> SortdistinplaceCursor {
  let result = sort_dist_inplace_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_inplace_cursor_fill(s : SortdistinplaceCursor, v : Double) -> SortdistinplaceCursor {
  let result = sort_dist_inplace_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_cursor_min(s : SortdistinplaceCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_cursor_max(s : SortdistinplaceCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_cursor_to_string(s : SortdistinplaceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_view_make(size : Int) -> SortdistinplaceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_view_len(s : SortdistinplaceView) -> Int { s.size }

pub fn sort_dist_inplace_view_get(s : SortdistinplaceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_view_set(s : SortdistinplaceView, i : Int, v : Double) -> SortdistinplaceView {
  let result = sort_dist_inplace_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_view_sum(s : SortdistinplaceView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_inplace_view_mean(s : SortdistinplaceView) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_inplace_view_sum(s) / s.size.to_double() }
}

pub fn sort_dist_inplace_view_scale(s : SortdistinplaceView, f : Double) -> SortdistinplaceView {
  let result = sort_dist_inplace_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_inplace_view_add(a : SortdistinplaceView, b : SortdistinplaceView) -> SortdistinplaceView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_inplace_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_inplace_view_copy(s : SortdistinplaceView) -> SortdistinplaceView {
  let result = sort_dist_inplace_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_inplace_view_fill(s : SortdistinplaceView, v : Double) -> SortdistinplaceView {
  let result = sort_dist_inplace_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_view_min(s : SortdistinplaceView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_view_max(s : SortdistinplaceView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_view_to_string(s : SortdistinplaceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_range_make(size : Int) -> SortdistinplaceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_range_len(s : SortdistinplaceRange) -> Int { s.size }

pub fn sort_dist_inplace_range_get(s : SortdistinplaceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_range_set(s : SortdistinplaceRange, i : Int, v : Double) -> SortdistinplaceRange {
  let result = sort_dist_inplace_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_range_sum(s : SortdistinplaceRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_inplace_range_mean(s : SortdistinplaceRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_inplace_range_sum(s) / s.size.to_double() }
}

pub fn sort_dist_inplace_range_scale(s : SortdistinplaceRange, f : Double) -> SortdistinplaceRange {
  let result = sort_dist_inplace_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_inplace_range_add(a : SortdistinplaceRange, b : SortdistinplaceRange) -> SortdistinplaceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_inplace_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_inplace_range_copy(s : SortdistinplaceRange) -> SortdistinplaceRange {
  let result = sort_dist_inplace_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_inplace_range_fill(s : SortdistinplaceRange, v : Double) -> SortdistinplaceRange {
  let result = sort_dist_inplace_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_range_min(s : SortdistinplaceRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_range_max(s : SortdistinplaceRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_range_to_string(s : SortdistinplaceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_slice_make(size : Int) -> SortdistinplaceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_slice_len(s : SortdistinplaceSlice) -> Int { s.size }

pub fn sort_dist_inplace_slice_get(s : SortdistinplaceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_slice_set(s : SortdistinplaceSlice, i : Int, v : Double) -> SortdistinplaceSlice {
  let result = sort_dist_inplace_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_slice_sum(s : SortdistinplaceSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_inplace_slice_mean(s : SortdistinplaceSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_inplace_slice_sum(s) / s.size.to_double() }
}

pub fn sort_dist_inplace_slice_scale(s : SortdistinplaceSlice, f : Double) -> SortdistinplaceSlice {
  let result = sort_dist_inplace_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_inplace_slice_add(a : SortdistinplaceSlice, b : SortdistinplaceSlice) -> SortdistinplaceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_inplace_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_inplace_slice_copy(s : SortdistinplaceSlice) -> SortdistinplaceSlice {
  let result = sort_dist_inplace_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_inplace_slice_fill(s : SortdistinplaceSlice, v : Double) -> SortdistinplaceSlice {
  let result = sort_dist_inplace_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_inplace_slice_min(s : SortdistinplaceSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_slice_max(s : SortdistinplaceSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_inplace_slice_to_string(s : SortdistinplaceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

