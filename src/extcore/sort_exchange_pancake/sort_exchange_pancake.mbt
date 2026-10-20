///===
/// extcore/sort_exchange_pancake

pub(all) struct SortexchangepancakePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_pancake_make_point(x : Double, y : Double) -> SortexchangepancakePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_pancake_make_point3(x : Double, y : Double, z : Double) -> SortexchangepancakePoint {
  { x, y, z, label: 0 }
}

pub fn sort_exchange_pancake_point_x(pt : SortexchangepancakePoint) -> Double { pt.x }

pub fn sort_exchange_pancake_point_y(pt : SortexchangepancakePoint) -> Double { pt.y }

pub fn sort_exchange_pancake_point_z(pt : SortexchangepancakePoint) -> Double { pt.z }

pub fn sort_exchange_pancake_point_label(pt : SortexchangepancakePoint) -> Int { pt.label }

pub fn sort_exchange_pancake_point_dist(a : SortexchangepancakePoint, b : SortexchangepancakePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_exchange_pancake_point_add(a : SortexchangepancakePoint, b : SortexchangepancakePoint) -> SortexchangepancakePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_exchange_pancake_point_sub(a : SortexchangepancakePoint, b : SortexchangepancakePoint) -> SortexchangepancakePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_exchange_pancake_point_scale(pt : SortexchangepancakePoint, s : Double) -> SortexchangepancakePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_exchange_pancake_point_dot(a : SortexchangepancakePoint, b : SortexchangepancakePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_exchange_pancake_point_cross(a : SortexchangepancakePoint, b : SortexchangepancakePoint) -> SortexchangepancakePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_exchange_pancake_point_norm(pt : SortexchangepancakePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_exchange_pancake_point_normalize(pt : SortexchangepancakePoint) -> SortexchangepancakePoint {
  let n = sort_exchange_pancake_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_exchange_pancake_point_scale(pt, 1.0 / n) }
}

pub fn sort_exchange_pancake_point_negate(pt : SortexchangepancakePoint) -> SortexchangepancakePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_exchange_pancake_point_mid(a : SortexchangepancakePoint, b : SortexchangepancakePoint) -> SortexchangepancakePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_exchange_pancake_point_lerp(a : SortexchangepancakePoint, b : SortexchangepancakePoint, t : Double) -> SortexchangepancakePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_exchange_pancake_point_to_string(pt : SortexchangepancakePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortexchangepancakeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_pancake_make_series(vals : Array[Double], name : String) -> SortexchangepancakeSeries {
  { vals, name, meta: 0 }
}

pub fn sort_exchange_pancake_series_len(s : SortexchangepancakeSeries) -> Int { s.vals.length() }

pub fn sort_exchange_pancake_series_sum(s : SortexchangepancakeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_exchange_pancake_series_mean(s : SortexchangepancakeSeries) -> Double { @_common.mean(s.vals) }

pub fn sort_exchange_pancake_series_min(s : SortexchangepancakeSeries) -> Double { @_common.min(s.vals) }

pub fn sort_exchange_pancake_series_max(s : SortexchangepancakeSeries) -> Double { @_common.max(s.vals) }

pub fn sort_exchange_pancake_series_range(s : SortexchangepancakeSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn sort_exchange_pancake_series_var(s : SortexchangepancakeSeries) -> Double { @_common.variance(s.vals) }

pub fn sort_exchange_pancake_series_std(s : SortexchangepancakeSeries) -> Double { @_common.std(s.vals) }

pub fn sort_exchange_pancake_series_median(s : SortexchangepancakeSeries) -> Double { @_common.median(s.vals) }

pub fn sort_exchange_pancake_series_scale(s : SortexchangepancakeSeries, f : Double) -> SortexchangepancakeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_exchange_pancake_series_add(a : SortexchangepancakeSeries, b : SortexchangepancakeSeries) -> SortexchangepancakeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_exchange_pancake_series_sub(a : SortexchangepancakeSeries, b : SortexchangepancakeSeries) -> SortexchangepancakeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_exchange_pancake_series_normalize(s : SortexchangepancakeSeries) -> SortexchangepancakeSeries {
  let mn = sort_exchange_pancake_series_min(s)
  let mx = sort_exchange_pancake_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_exchange_pancake_series_cumsum(s : SortexchangepancakeSeries) -> SortexchangepancakeSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_exchange_pancake_series_to_string(s : SortexchangepancakeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangepancakeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_pancake_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangepancakeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_pancake_matrix_identity(n : Int) -> SortexchangepancakeMatrix {
  let m = sort_exchange_pancake_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_exchange_pancake_matrix_get(m : SortexchangepancakeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_exchange_pancake_matrix_transpose(m : SortexchangepancakeMatrix) -> SortexchangepancakeMatrix {
  let result = sort_exchange_pancake_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_exchange_pancake_matrix_add(a : SortexchangepancakeMatrix, b : SortexchangepancakeMatrix) -> SortexchangepancakeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_exchange_pancake_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_exchange_pancake_matrix_scale(m : SortexchangepancakeMatrix, s : Double) -> SortexchangepancakeMatrix {
  let result = sort_exchange_pancake_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_exchange_pancake_matrix_multiply(a : SortexchangepancakeMatrix, b : SortexchangepancakeMatrix) -> SortexchangepancakeMatrix {
  if a.cols != b.rows { return sort_exchange_pancake_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_exchange_pancake_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_exchange_pancake_matrix_trace(m : SortexchangepancakeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_exchange_pancake_matrix_det(m : SortexchangepancakeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_exchange_pancake_matrix_norm(m : SortexchangepancakeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_exchange_pancake_matrix_to_string(m : SortexchangepancakeMatrix) -> String {
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

pub(all) struct SortexchangepancakeVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_pancake_make_vector(comps : Array[Double]) -> SortexchangepancakeVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_pancake_vector_zero(dim : Int) -> SortexchangepancakeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_exchange_pancake_vector_add(a : SortexchangepancakeVector, b : SortexchangepancakeVector) -> SortexchangepancakeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_exchange_pancake_vector_sub(a : SortexchangepancakeVector, b : SortexchangepancakeVector) -> SortexchangepancakeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_exchange_pancake_vector_scale(v : SortexchangepancakeVector, s : Double) -> SortexchangepancakeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_exchange_pancake_vector_dot(a : SortexchangepancakeVector, b : SortexchangepancakeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_exchange_pancake_vector_norm(v : SortexchangepancakeVector) -> Double { @_common.sqrt(sort_exchange_pancake_vector_dot(v, v)) }

pub fn sort_exchange_pancake_vector_normalize(v : SortexchangepancakeVector) -> SortexchangepancakeVector {
  let n = sort_exchange_pancake_vector_norm(v)
  if n < 0.0000001 { v } else { sort_exchange_pancake_vector_scale(v, 1.0 / n) }
}

pub fn sort_exchange_pancake_vector_dist(a : SortexchangepancakeVector, b : SortexchangepancakeVector) -> Double {
  sort_exchange_pancake_vector_norm(sort_exchange_pancake_vector_sub(a, b))
}

pub fn sort_exchange_pancake_vector_to_string(v : SortexchangepancakeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_exchange_pancake_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_exchange_pancake_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_exchange_pancake_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_exchange_pancake_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_exchange_pancake_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_exchange_pancake_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_exchange_pancake_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_exchange_pancake_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_exchange_pancake_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_exchange_pancake_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_exchange_pancake_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_exchange_pancake_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_exchange_pancake_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_exchange_pancake_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_exchange_pancake_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_exchange_pancake_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_exchange_pancake_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_exchange_pancake_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_exchange_pancake_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_exchange_pancake_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_exchange_pancake_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_exchange_pancake_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_exchange_pancake_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_exchange_pancake_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_exchange_pancake_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_exchange_pancake_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_exchange_pancake_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_exchange_pancake_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_exchange_pancake_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortexchangepancakeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_frame_make(size : Int) -> SortexchangepancakeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_frame_len(s : SortexchangepancakeFrame) -> Int { s.size }

pub fn sort_exchange_pancake_frame_get(s : SortexchangepancakeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_frame_set(s : SortexchangepancakeFrame, i : Int, v : Double) -> SortexchangepancakeFrame {
  let result = sort_exchange_pancake_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_frame_sum(s : SortexchangepancakeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_pancake_frame_mean(s : SortexchangepancakeFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_pancake_frame_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_pancake_frame_scale(s : SortexchangepancakeFrame, f : Double) -> SortexchangepancakeFrame {
  let result = sort_exchange_pancake_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_pancake_frame_add(a : SortexchangepancakeFrame, b : SortexchangepancakeFrame) -> SortexchangepancakeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_pancake_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_pancake_frame_copy(s : SortexchangepancakeFrame) -> SortexchangepancakeFrame {
  let result = sort_exchange_pancake_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_pancake_frame_fill(s : SortexchangepancakeFrame, v : Double) -> SortexchangepancakeFrame {
  let result = sort_exchange_pancake_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_frame_min(s : SortexchangepancakeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_frame_max(s : SortexchangepancakeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_frame_to_string(s : SortexchangepancakeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_table_make(size : Int) -> SortexchangepancakeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_table_len(s : SortexchangepancakeTable) -> Int { s.size }

pub fn sort_exchange_pancake_table_get(s : SortexchangepancakeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_table_set(s : SortexchangepancakeTable, i : Int, v : Double) -> SortexchangepancakeTable {
  let result = sort_exchange_pancake_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_table_sum(s : SortexchangepancakeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_pancake_table_mean(s : SortexchangepancakeTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_pancake_table_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_pancake_table_scale(s : SortexchangepancakeTable, f : Double) -> SortexchangepancakeTable {
  let result = sort_exchange_pancake_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_pancake_table_add(a : SortexchangepancakeTable, b : SortexchangepancakeTable) -> SortexchangepancakeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_pancake_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_pancake_table_copy(s : SortexchangepancakeTable) -> SortexchangepancakeTable {
  let result = sort_exchange_pancake_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_pancake_table_fill(s : SortexchangepancakeTable, v : Double) -> SortexchangepancakeTable {
  let result = sort_exchange_pancake_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_table_min(s : SortexchangepancakeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_table_max(s : SortexchangepancakeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_table_to_string(s : SortexchangepancakeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_graphn_make(size : Int) -> SortexchangepancakeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_graphn_len(s : SortexchangepancakeGraphN) -> Int { s.size }

pub fn sort_exchange_pancake_graphn_get(s : SortexchangepancakeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_graphn_set(s : SortexchangepancakeGraphN, i : Int, v : Double) -> SortexchangepancakeGraphN {
  let result = sort_exchange_pancake_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_graphn_sum(s : SortexchangepancakeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_pancake_graphn_mean(s : SortexchangepancakeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_pancake_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_pancake_graphn_scale(s : SortexchangepancakeGraphN, f : Double) -> SortexchangepancakeGraphN {
  let result = sort_exchange_pancake_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_pancake_graphn_add(a : SortexchangepancakeGraphN, b : SortexchangepancakeGraphN) -> SortexchangepancakeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_pancake_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_pancake_graphn_copy(s : SortexchangepancakeGraphN) -> SortexchangepancakeGraphN {
  let result = sort_exchange_pancake_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_pancake_graphn_fill(s : SortexchangepancakeGraphN, v : Double) -> SortexchangepancakeGraphN {
  let result = sort_exchange_pancake_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_graphn_min(s : SortexchangepancakeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_graphn_max(s : SortexchangepancakeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_graphn_to_string(s : SortexchangepancakeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_node_make(size : Int) -> SortexchangepancakeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_node_len(s : SortexchangepancakeNode) -> Int { s.size }

pub fn sort_exchange_pancake_node_get(s : SortexchangepancakeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_node_set(s : SortexchangepancakeNode, i : Int, v : Double) -> SortexchangepancakeNode {
  let result = sort_exchange_pancake_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_node_sum(s : SortexchangepancakeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_pancake_node_mean(s : SortexchangepancakeNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_pancake_node_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_pancake_node_scale(s : SortexchangepancakeNode, f : Double) -> SortexchangepancakeNode {
  let result = sort_exchange_pancake_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_pancake_node_add(a : SortexchangepancakeNode, b : SortexchangepancakeNode) -> SortexchangepancakeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_pancake_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_pancake_node_copy(s : SortexchangepancakeNode) -> SortexchangepancakeNode {
  let result = sort_exchange_pancake_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_pancake_node_fill(s : SortexchangepancakeNode, v : Double) -> SortexchangepancakeNode {
  let result = sort_exchange_pancake_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_node_min(s : SortexchangepancakeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_node_max(s : SortexchangepancakeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_node_to_string(s : SortexchangepancakeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_edge_make(size : Int) -> SortexchangepancakeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_edge_len(s : SortexchangepancakeEdge) -> Int { s.size }

pub fn sort_exchange_pancake_edge_get(s : SortexchangepancakeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_edge_set(s : SortexchangepancakeEdge, i : Int, v : Double) -> SortexchangepancakeEdge {
  let result = sort_exchange_pancake_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_edge_sum(s : SortexchangepancakeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_pancake_edge_mean(s : SortexchangepancakeEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_pancake_edge_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_pancake_edge_scale(s : SortexchangepancakeEdge, f : Double) -> SortexchangepancakeEdge {
  let result = sort_exchange_pancake_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_pancake_edge_add(a : SortexchangepancakeEdge, b : SortexchangepancakeEdge) -> SortexchangepancakeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_pancake_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_pancake_edge_copy(s : SortexchangepancakeEdge) -> SortexchangepancakeEdge {
  let result = sort_exchange_pancake_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_pancake_edge_fill(s : SortexchangepancakeEdge, v : Double) -> SortexchangepancakeEdge {
  let result = sort_exchange_pancake_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_edge_min(s : SortexchangepancakeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_edge_max(s : SortexchangepancakeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_edge_to_string(s : SortexchangepancakeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_path_make(size : Int) -> SortexchangepancakePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_path_len(s : SortexchangepancakePath) -> Int { s.size }

pub fn sort_exchange_pancake_path_get(s : SortexchangepancakePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_path_set(s : SortexchangepancakePath, i : Int, v : Double) -> SortexchangepancakePath {
  let result = sort_exchange_pancake_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_path_sum(s : SortexchangepancakePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_pancake_path_mean(s : SortexchangepancakePath) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_pancake_path_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_pancake_path_scale(s : SortexchangepancakePath, f : Double) -> SortexchangepancakePath {
  let result = sort_exchange_pancake_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_pancake_path_add(a : SortexchangepancakePath, b : SortexchangepancakePath) -> SortexchangepancakePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_pancake_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_pancake_path_copy(s : SortexchangepancakePath) -> SortexchangepancakePath {
  let result = sort_exchange_pancake_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_pancake_path_fill(s : SortexchangepancakePath, v : Double) -> SortexchangepancakePath {
  let result = sort_exchange_pancake_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_path_min(s : SortexchangepancakePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_path_max(s : SortexchangepancakePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_path_to_string(s : SortexchangepancakePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_cluster_make(size : Int) -> SortexchangepancakeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_cluster_len(s : SortexchangepancakeCluster) -> Int { s.size }

pub fn sort_exchange_pancake_cluster_get(s : SortexchangepancakeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_cluster_set(s : SortexchangepancakeCluster, i : Int, v : Double) -> SortexchangepancakeCluster {
  let result = sort_exchange_pancake_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_cluster_sum(s : SortexchangepancakeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_pancake_cluster_mean(s : SortexchangepancakeCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_pancake_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_pancake_cluster_scale(s : SortexchangepancakeCluster, f : Double) -> SortexchangepancakeCluster {
  let result = sort_exchange_pancake_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_pancake_cluster_add(a : SortexchangepancakeCluster, b : SortexchangepancakeCluster) -> SortexchangepancakeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_pancake_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_pancake_cluster_copy(s : SortexchangepancakeCluster) -> SortexchangepancakeCluster {
  let result = sort_exchange_pancake_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_pancake_cluster_fill(s : SortexchangepancakeCluster, v : Double) -> SortexchangepancakeCluster {
  let result = sort_exchange_pancake_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_cluster_min(s : SortexchangepancakeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_cluster_max(s : SortexchangepancakeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_cluster_to_string(s : SortexchangepancakeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_model_make(size : Int) -> SortexchangepancakeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_model_len(s : SortexchangepancakeModel) -> Int { s.size }

pub fn sort_exchange_pancake_model_get(s : SortexchangepancakeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_model_set(s : SortexchangepancakeModel, i : Int, v : Double) -> SortexchangepancakeModel {
  let result = sort_exchange_pancake_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_model_sum(s : SortexchangepancakeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_pancake_model_mean(s : SortexchangepancakeModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_pancake_model_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_pancake_model_scale(s : SortexchangepancakeModel, f : Double) -> SortexchangepancakeModel {
  let result = sort_exchange_pancake_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_pancake_model_add(a : SortexchangepancakeModel, b : SortexchangepancakeModel) -> SortexchangepancakeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_pancake_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_pancake_model_copy(s : SortexchangepancakeModel) -> SortexchangepancakeModel {
  let result = sort_exchange_pancake_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_pancake_model_fill(s : SortexchangepancakeModel, v : Double) -> SortexchangepancakeModel {
  let result = sort_exchange_pancake_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_model_min(s : SortexchangepancakeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_model_max(s : SortexchangepancakeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_model_to_string(s : SortexchangepancakeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_layer_make(size : Int) -> SortexchangepancakeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_layer_len(s : SortexchangepancakeLayer) -> Int { s.size }

pub fn sort_exchange_pancake_layer_get(s : SortexchangepancakeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_layer_set(s : SortexchangepancakeLayer, i : Int, v : Double) -> SortexchangepancakeLayer {
  let result = sort_exchange_pancake_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_layer_sum(s : SortexchangepancakeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_pancake_layer_mean(s : SortexchangepancakeLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_pancake_layer_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_pancake_layer_scale(s : SortexchangepancakeLayer, f : Double) -> SortexchangepancakeLayer {
  let result = sort_exchange_pancake_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_pancake_layer_add(a : SortexchangepancakeLayer, b : SortexchangepancakeLayer) -> SortexchangepancakeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_pancake_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_pancake_layer_copy(s : SortexchangepancakeLayer) -> SortexchangepancakeLayer {
  let result = sort_exchange_pancake_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_pancake_layer_fill(s : SortexchangepancakeLayer, v : Double) -> SortexchangepancakeLayer {
  let result = sort_exchange_pancake_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_layer_min(s : SortexchangepancakeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_layer_max(s : SortexchangepancakeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_layer_to_string(s : SortexchangepancakeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_buffer_make(size : Int) -> SortexchangepancakeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_buffer_len(s : SortexchangepancakeBuffer) -> Int { s.size }

pub fn sort_exchange_pancake_buffer_get(s : SortexchangepancakeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_buffer_set(s : SortexchangepancakeBuffer, i : Int, v : Double) -> SortexchangepancakeBuffer {
  let result = sort_exchange_pancake_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_buffer_sum(s : SortexchangepancakeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_pancake_buffer_mean(s : SortexchangepancakeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_pancake_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_pancake_buffer_scale(s : SortexchangepancakeBuffer, f : Double) -> SortexchangepancakeBuffer {
  let result = sort_exchange_pancake_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_pancake_buffer_add(a : SortexchangepancakeBuffer, b : SortexchangepancakeBuffer) -> SortexchangepancakeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_pancake_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_pancake_buffer_copy(s : SortexchangepancakeBuffer) -> SortexchangepancakeBuffer {
  let result = sort_exchange_pancake_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_pancake_buffer_fill(s : SortexchangepancakeBuffer, v : Double) -> SortexchangepancakeBuffer {
  let result = sort_exchange_pancake_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_buffer_min(s : SortexchangepancakeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_buffer_max(s : SortexchangepancakeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_buffer_to_string(s : SortexchangepancakeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_cursor_make(size : Int) -> SortexchangepancakeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_cursor_len(s : SortexchangepancakeCursor) -> Int { s.size }

pub fn sort_exchange_pancake_cursor_get(s : SortexchangepancakeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_cursor_set(s : SortexchangepancakeCursor, i : Int, v : Double) -> SortexchangepancakeCursor {
  let result = sort_exchange_pancake_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_cursor_sum(s : SortexchangepancakeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_pancake_cursor_mean(s : SortexchangepancakeCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_pancake_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_pancake_cursor_scale(s : SortexchangepancakeCursor, f : Double) -> SortexchangepancakeCursor {
  let result = sort_exchange_pancake_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_pancake_cursor_add(a : SortexchangepancakeCursor, b : SortexchangepancakeCursor) -> SortexchangepancakeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_pancake_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_pancake_cursor_copy(s : SortexchangepancakeCursor) -> SortexchangepancakeCursor {
  let result = sort_exchange_pancake_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_pancake_cursor_fill(s : SortexchangepancakeCursor, v : Double) -> SortexchangepancakeCursor {
  let result = sort_exchange_pancake_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_cursor_min(s : SortexchangepancakeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_cursor_max(s : SortexchangepancakeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_cursor_to_string(s : SortexchangepancakeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_view_make(size : Int) -> SortexchangepancakeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_view_len(s : SortexchangepancakeView) -> Int { s.size }

pub fn sort_exchange_pancake_view_get(s : SortexchangepancakeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_view_set(s : SortexchangepancakeView, i : Int, v : Double) -> SortexchangepancakeView {
  let result = sort_exchange_pancake_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_view_sum(s : SortexchangepancakeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_pancake_view_mean(s : SortexchangepancakeView) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_pancake_view_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_pancake_view_scale(s : SortexchangepancakeView, f : Double) -> SortexchangepancakeView {
  let result = sort_exchange_pancake_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_pancake_view_add(a : SortexchangepancakeView, b : SortexchangepancakeView) -> SortexchangepancakeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_pancake_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_pancake_view_copy(s : SortexchangepancakeView) -> SortexchangepancakeView {
  let result = sort_exchange_pancake_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_pancake_view_fill(s : SortexchangepancakeView, v : Double) -> SortexchangepancakeView {
  let result = sort_exchange_pancake_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_view_min(s : SortexchangepancakeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_view_max(s : SortexchangepancakeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_view_to_string(s : SortexchangepancakeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_range_make(size : Int) -> SortexchangepancakeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_range_len(s : SortexchangepancakeRange) -> Int { s.size }

pub fn sort_exchange_pancake_range_get(s : SortexchangepancakeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_range_set(s : SortexchangepancakeRange, i : Int, v : Double) -> SortexchangepancakeRange {
  let result = sort_exchange_pancake_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_range_sum(s : SortexchangepancakeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_pancake_range_mean(s : SortexchangepancakeRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_pancake_range_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_pancake_range_scale(s : SortexchangepancakeRange, f : Double) -> SortexchangepancakeRange {
  let result = sort_exchange_pancake_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_pancake_range_add(a : SortexchangepancakeRange, b : SortexchangepancakeRange) -> SortexchangepancakeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_pancake_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_pancake_range_copy(s : SortexchangepancakeRange) -> SortexchangepancakeRange {
  let result = sort_exchange_pancake_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_pancake_range_fill(s : SortexchangepancakeRange, v : Double) -> SortexchangepancakeRange {
  let result = sort_exchange_pancake_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_range_min(s : SortexchangepancakeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_range_max(s : SortexchangepancakeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_range_to_string(s : SortexchangepancakeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_slice_make(size : Int) -> SortexchangepancakeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_slice_len(s : SortexchangepancakeSlice) -> Int { s.size }

pub fn sort_exchange_pancake_slice_get(s : SortexchangepancakeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_slice_set(s : SortexchangepancakeSlice, i : Int, v : Double) -> SortexchangepancakeSlice {
  let result = sort_exchange_pancake_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_slice_sum(s : SortexchangepancakeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_pancake_slice_mean(s : SortexchangepancakeSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_pancake_slice_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_pancake_slice_scale(s : SortexchangepancakeSlice, f : Double) -> SortexchangepancakeSlice {
  let result = sort_exchange_pancake_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_pancake_slice_add(a : SortexchangepancakeSlice, b : SortexchangepancakeSlice) -> SortexchangepancakeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_pancake_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_pancake_slice_copy(s : SortexchangepancakeSlice) -> SortexchangepancakeSlice {
  let result = sort_exchange_pancake_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_pancake_slice_fill(s : SortexchangepancakeSlice, v : Double) -> SortexchangepancakeSlice {
  let result = sort_exchange_pancake_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_pancake_slice_min(s : SortexchangepancakeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_slice_max(s : SortexchangepancakeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_pancake_slice_to_string(s : SortexchangepancakeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

