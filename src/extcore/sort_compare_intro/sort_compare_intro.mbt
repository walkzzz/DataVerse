///===
/// extcore/sort_compare_intro

pub(all) struct SortcompareintroPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_intro_make_point(x : Double, y : Double) -> SortcompareintroPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_intro_make_point3(x : Double, y : Double, z : Double) -> SortcompareintroPoint {
  { x, y, z, label: 0 }
}

pub fn sort_compare_intro_point_x(pt : SortcompareintroPoint) -> Double { pt.x }

pub fn sort_compare_intro_point_y(pt : SortcompareintroPoint) -> Double { pt.y }

pub fn sort_compare_intro_point_z(pt : SortcompareintroPoint) -> Double { pt.z }

pub fn sort_compare_intro_point_label(pt : SortcompareintroPoint) -> Int { pt.label }

pub fn sort_compare_intro_point_dist(a : SortcompareintroPoint, b : SortcompareintroPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_compare_intro_point_add(a : SortcompareintroPoint, b : SortcompareintroPoint) -> SortcompareintroPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_compare_intro_point_sub(a : SortcompareintroPoint, b : SortcompareintroPoint) -> SortcompareintroPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_compare_intro_point_scale(pt : SortcompareintroPoint, s : Double) -> SortcompareintroPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_compare_intro_point_dot(a : SortcompareintroPoint, b : SortcompareintroPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_compare_intro_point_cross(a : SortcompareintroPoint, b : SortcompareintroPoint) -> SortcompareintroPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_compare_intro_point_norm(pt : SortcompareintroPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_compare_intro_point_normalize(pt : SortcompareintroPoint) -> SortcompareintroPoint {
  let n = sort_compare_intro_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_compare_intro_point_scale(pt, 1.0 / n) }
}

pub fn sort_compare_intro_point_negate(pt : SortcompareintroPoint) -> SortcompareintroPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_compare_intro_point_mid(a : SortcompareintroPoint, b : SortcompareintroPoint) -> SortcompareintroPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_compare_intro_point_lerp(a : SortcompareintroPoint, b : SortcompareintroPoint, t : Double) -> SortcompareintroPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_compare_intro_point_to_string(pt : SortcompareintroPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortcompareintroSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_intro_make_series(vals : Array[Double], name : String) -> SortcompareintroSeries {
  { vals, name, meta: 0 }
}

pub fn sort_compare_intro_series_len(s : SortcompareintroSeries) -> Int { s.vals.length() }

pub fn sort_compare_intro_series_sum(s : SortcompareintroSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_compare_intro_series_mean(s : SortcompareintroSeries) -> Double { @_common.mean(s.vals) }

pub fn sort_compare_intro_series_min(s : SortcompareintroSeries) -> Double { @_common.min(s.vals) }

pub fn sort_compare_intro_series_max(s : SortcompareintroSeries) -> Double { @_common.max(s.vals) }

pub fn sort_compare_intro_series_range(s : SortcompareintroSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn sort_compare_intro_series_var(s : SortcompareintroSeries) -> Double { @_common.variance(s.vals) }

pub fn sort_compare_intro_series_std(s : SortcompareintroSeries) -> Double { @_common.std(s.vals) }

pub fn sort_compare_intro_series_median(s : SortcompareintroSeries) -> Double { @_common.median(s.vals) }

pub fn sort_compare_intro_series_scale(s : SortcompareintroSeries, f : Double) -> SortcompareintroSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_compare_intro_series_add(a : SortcompareintroSeries, b : SortcompareintroSeries) -> SortcompareintroSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_compare_intro_series_sub(a : SortcompareintroSeries, b : SortcompareintroSeries) -> SortcompareintroSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_compare_intro_series_normalize(s : SortcompareintroSeries) -> SortcompareintroSeries {
  let mn = sort_compare_intro_series_min(s)
  let mx = sort_compare_intro_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_compare_intro_series_cumsum(s : SortcompareintroSeries) -> SortcompareintroSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_compare_intro_series_to_string(s : SortcompareintroSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcompareintroMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_intro_make_matrix(rows : Int, cols : Int, val : Double) -> SortcompareintroMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_intro_matrix_identity(n : Int) -> SortcompareintroMatrix {
  let m = sort_compare_intro_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_compare_intro_matrix_get(m : SortcompareintroMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_compare_intro_matrix_transpose(m : SortcompareintroMatrix) -> SortcompareintroMatrix {
  let result = sort_compare_intro_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_compare_intro_matrix_add(a : SortcompareintroMatrix, b : SortcompareintroMatrix) -> SortcompareintroMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_compare_intro_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_compare_intro_matrix_scale(m : SortcompareintroMatrix, s : Double) -> SortcompareintroMatrix {
  let result = sort_compare_intro_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_compare_intro_matrix_multiply(a : SortcompareintroMatrix, b : SortcompareintroMatrix) -> SortcompareintroMatrix {
  if a.cols != b.rows { return sort_compare_intro_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_compare_intro_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_compare_intro_matrix_trace(m : SortcompareintroMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_compare_intro_matrix_det(m : SortcompareintroMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_compare_intro_matrix_norm(m : SortcompareintroMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_compare_intro_matrix_to_string(m : SortcompareintroMatrix) -> String {
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

pub(all) struct SortcompareintroVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_intro_make_vector(comps : Array[Double]) -> SortcompareintroVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_intro_vector_zero(dim : Int) -> SortcompareintroVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_compare_intro_vector_add(a : SortcompareintroVector, b : SortcompareintroVector) -> SortcompareintroVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_intro_vector_sub(a : SortcompareintroVector, b : SortcompareintroVector) -> SortcompareintroVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_intro_vector_scale(v : SortcompareintroVector, s : Double) -> SortcompareintroVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_compare_intro_vector_dot(a : SortcompareintroVector, b : SortcompareintroVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_compare_intro_vector_norm(v : SortcompareintroVector) -> Double { @_common.sqrt(sort_compare_intro_vector_dot(v, v)) }

pub fn sort_compare_intro_vector_normalize(v : SortcompareintroVector) -> SortcompareintroVector {
  let n = sort_compare_intro_vector_norm(v)
  if n < 0.0000001 { v } else { sort_compare_intro_vector_scale(v, 1.0 / n) }
}

pub fn sort_compare_intro_vector_dist(a : SortcompareintroVector, b : SortcompareintroVector) -> Double {
  sort_compare_intro_vector_norm(sort_compare_intro_vector_sub(a, b))
}

pub fn sort_compare_intro_vector_to_string(v : SortcompareintroVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_intro_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_compare_intro_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_compare_intro_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_compare_intro_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_compare_intro_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_compare_intro_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_compare_intro_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_compare_intro_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_compare_intro_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_compare_intro_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_compare_intro_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_compare_intro_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_compare_intro_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_compare_intro_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_compare_intro_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_compare_intro_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_compare_intro_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_compare_intro_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_compare_intro_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_compare_intro_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_compare_intro_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_compare_intro_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_compare_intro_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_compare_intro_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_compare_intro_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_compare_intro_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_compare_intro_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_compare_intro_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_compare_intro_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortcompareintroFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_frame_make(size : Int) -> SortcompareintroFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_frame_len(s : SortcompareintroFrame) -> Int { s.size }

pub fn sort_compare_intro_frame_get(s : SortcompareintroFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_frame_set(s : SortcompareintroFrame, i : Int, v : Double) -> SortcompareintroFrame {
  let result = sort_compare_intro_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_frame_sum(s : SortcompareintroFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_intro_frame_mean(s : SortcompareintroFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_intro_frame_sum(s) / s.size.to_double() }
}

pub fn sort_compare_intro_frame_scale(s : SortcompareintroFrame, f : Double) -> SortcompareintroFrame {
  let result = sort_compare_intro_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_intro_frame_add(a : SortcompareintroFrame, b : SortcompareintroFrame) -> SortcompareintroFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_intro_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_intro_frame_copy(s : SortcompareintroFrame) -> SortcompareintroFrame {
  let result = sort_compare_intro_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_intro_frame_fill(s : SortcompareintroFrame, v : Double) -> SortcompareintroFrame {
  let result = sort_compare_intro_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_frame_min(s : SortcompareintroFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_frame_max(s : SortcompareintroFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_frame_to_string(s : SortcompareintroFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_table_make(size : Int) -> SortcompareintroTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_table_len(s : SortcompareintroTable) -> Int { s.size }

pub fn sort_compare_intro_table_get(s : SortcompareintroTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_table_set(s : SortcompareintroTable, i : Int, v : Double) -> SortcompareintroTable {
  let result = sort_compare_intro_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_table_sum(s : SortcompareintroTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_intro_table_mean(s : SortcompareintroTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_intro_table_sum(s) / s.size.to_double() }
}

pub fn sort_compare_intro_table_scale(s : SortcompareintroTable, f : Double) -> SortcompareintroTable {
  let result = sort_compare_intro_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_intro_table_add(a : SortcompareintroTable, b : SortcompareintroTable) -> SortcompareintroTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_intro_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_intro_table_copy(s : SortcompareintroTable) -> SortcompareintroTable {
  let result = sort_compare_intro_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_intro_table_fill(s : SortcompareintroTable, v : Double) -> SortcompareintroTable {
  let result = sort_compare_intro_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_table_min(s : SortcompareintroTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_table_max(s : SortcompareintroTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_table_to_string(s : SortcompareintroTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_graphn_make(size : Int) -> SortcompareintroGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_graphn_len(s : SortcompareintroGraphN) -> Int { s.size }

pub fn sort_compare_intro_graphn_get(s : SortcompareintroGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_graphn_set(s : SortcompareintroGraphN, i : Int, v : Double) -> SortcompareintroGraphN {
  let result = sort_compare_intro_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_graphn_sum(s : SortcompareintroGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_intro_graphn_mean(s : SortcompareintroGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_intro_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_compare_intro_graphn_scale(s : SortcompareintroGraphN, f : Double) -> SortcompareintroGraphN {
  let result = sort_compare_intro_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_intro_graphn_add(a : SortcompareintroGraphN, b : SortcompareintroGraphN) -> SortcompareintroGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_intro_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_intro_graphn_copy(s : SortcompareintroGraphN) -> SortcompareintroGraphN {
  let result = sort_compare_intro_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_intro_graphn_fill(s : SortcompareintroGraphN, v : Double) -> SortcompareintroGraphN {
  let result = sort_compare_intro_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_graphn_min(s : SortcompareintroGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_graphn_max(s : SortcompareintroGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_graphn_to_string(s : SortcompareintroGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_node_make(size : Int) -> SortcompareintroNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_node_len(s : SortcompareintroNode) -> Int { s.size }

pub fn sort_compare_intro_node_get(s : SortcompareintroNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_node_set(s : SortcompareintroNode, i : Int, v : Double) -> SortcompareintroNode {
  let result = sort_compare_intro_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_node_sum(s : SortcompareintroNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_intro_node_mean(s : SortcompareintroNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_intro_node_sum(s) / s.size.to_double() }
}

pub fn sort_compare_intro_node_scale(s : SortcompareintroNode, f : Double) -> SortcompareintroNode {
  let result = sort_compare_intro_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_intro_node_add(a : SortcompareintroNode, b : SortcompareintroNode) -> SortcompareintroNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_intro_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_intro_node_copy(s : SortcompareintroNode) -> SortcompareintroNode {
  let result = sort_compare_intro_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_intro_node_fill(s : SortcompareintroNode, v : Double) -> SortcompareintroNode {
  let result = sort_compare_intro_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_node_min(s : SortcompareintroNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_node_max(s : SortcompareintroNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_node_to_string(s : SortcompareintroNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_edge_make(size : Int) -> SortcompareintroEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_edge_len(s : SortcompareintroEdge) -> Int { s.size }

pub fn sort_compare_intro_edge_get(s : SortcompareintroEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_edge_set(s : SortcompareintroEdge, i : Int, v : Double) -> SortcompareintroEdge {
  let result = sort_compare_intro_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_edge_sum(s : SortcompareintroEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_intro_edge_mean(s : SortcompareintroEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_intro_edge_sum(s) / s.size.to_double() }
}

pub fn sort_compare_intro_edge_scale(s : SortcompareintroEdge, f : Double) -> SortcompareintroEdge {
  let result = sort_compare_intro_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_intro_edge_add(a : SortcompareintroEdge, b : SortcompareintroEdge) -> SortcompareintroEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_intro_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_intro_edge_copy(s : SortcompareintroEdge) -> SortcompareintroEdge {
  let result = sort_compare_intro_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_intro_edge_fill(s : SortcompareintroEdge, v : Double) -> SortcompareintroEdge {
  let result = sort_compare_intro_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_edge_min(s : SortcompareintroEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_edge_max(s : SortcompareintroEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_edge_to_string(s : SortcompareintroEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_path_make(size : Int) -> SortcompareintroPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_path_len(s : SortcompareintroPath) -> Int { s.size }

pub fn sort_compare_intro_path_get(s : SortcompareintroPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_path_set(s : SortcompareintroPath, i : Int, v : Double) -> SortcompareintroPath {
  let result = sort_compare_intro_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_path_sum(s : SortcompareintroPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_intro_path_mean(s : SortcompareintroPath) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_intro_path_sum(s) / s.size.to_double() }
}

pub fn sort_compare_intro_path_scale(s : SortcompareintroPath, f : Double) -> SortcompareintroPath {
  let result = sort_compare_intro_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_intro_path_add(a : SortcompareintroPath, b : SortcompareintroPath) -> SortcompareintroPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_intro_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_intro_path_copy(s : SortcompareintroPath) -> SortcompareintroPath {
  let result = sort_compare_intro_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_intro_path_fill(s : SortcompareintroPath, v : Double) -> SortcompareintroPath {
  let result = sort_compare_intro_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_path_min(s : SortcompareintroPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_path_max(s : SortcompareintroPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_path_to_string(s : SortcompareintroPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_cluster_make(size : Int) -> SortcompareintroCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_cluster_len(s : SortcompareintroCluster) -> Int { s.size }

pub fn sort_compare_intro_cluster_get(s : SortcompareintroCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_cluster_set(s : SortcompareintroCluster, i : Int, v : Double) -> SortcompareintroCluster {
  let result = sort_compare_intro_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_cluster_sum(s : SortcompareintroCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_intro_cluster_mean(s : SortcompareintroCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_intro_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_compare_intro_cluster_scale(s : SortcompareintroCluster, f : Double) -> SortcompareintroCluster {
  let result = sort_compare_intro_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_intro_cluster_add(a : SortcompareintroCluster, b : SortcompareintroCluster) -> SortcompareintroCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_intro_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_intro_cluster_copy(s : SortcompareintroCluster) -> SortcompareintroCluster {
  let result = sort_compare_intro_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_intro_cluster_fill(s : SortcompareintroCluster, v : Double) -> SortcompareintroCluster {
  let result = sort_compare_intro_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_cluster_min(s : SortcompareintroCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_cluster_max(s : SortcompareintroCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_cluster_to_string(s : SortcompareintroCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_model_make(size : Int) -> SortcompareintroModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_model_len(s : SortcompareintroModel) -> Int { s.size }

pub fn sort_compare_intro_model_get(s : SortcompareintroModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_model_set(s : SortcompareintroModel, i : Int, v : Double) -> SortcompareintroModel {
  let result = sort_compare_intro_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_model_sum(s : SortcompareintroModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_intro_model_mean(s : SortcompareintroModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_intro_model_sum(s) / s.size.to_double() }
}

pub fn sort_compare_intro_model_scale(s : SortcompareintroModel, f : Double) -> SortcompareintroModel {
  let result = sort_compare_intro_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_intro_model_add(a : SortcompareintroModel, b : SortcompareintroModel) -> SortcompareintroModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_intro_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_intro_model_copy(s : SortcompareintroModel) -> SortcompareintroModel {
  let result = sort_compare_intro_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_intro_model_fill(s : SortcompareintroModel, v : Double) -> SortcompareintroModel {
  let result = sort_compare_intro_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_model_min(s : SortcompareintroModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_model_max(s : SortcompareintroModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_model_to_string(s : SortcompareintroModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_layer_make(size : Int) -> SortcompareintroLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_layer_len(s : SortcompareintroLayer) -> Int { s.size }

pub fn sort_compare_intro_layer_get(s : SortcompareintroLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_layer_set(s : SortcompareintroLayer, i : Int, v : Double) -> SortcompareintroLayer {
  let result = sort_compare_intro_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_layer_sum(s : SortcompareintroLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_intro_layer_mean(s : SortcompareintroLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_intro_layer_sum(s) / s.size.to_double() }
}

pub fn sort_compare_intro_layer_scale(s : SortcompareintroLayer, f : Double) -> SortcompareintroLayer {
  let result = sort_compare_intro_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_intro_layer_add(a : SortcompareintroLayer, b : SortcompareintroLayer) -> SortcompareintroLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_intro_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_intro_layer_copy(s : SortcompareintroLayer) -> SortcompareintroLayer {
  let result = sort_compare_intro_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_intro_layer_fill(s : SortcompareintroLayer, v : Double) -> SortcompareintroLayer {
  let result = sort_compare_intro_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_layer_min(s : SortcompareintroLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_layer_max(s : SortcompareintroLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_layer_to_string(s : SortcompareintroLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_buffer_make(size : Int) -> SortcompareintroBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_buffer_len(s : SortcompareintroBuffer) -> Int { s.size }

pub fn sort_compare_intro_buffer_get(s : SortcompareintroBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_buffer_set(s : SortcompareintroBuffer, i : Int, v : Double) -> SortcompareintroBuffer {
  let result = sort_compare_intro_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_buffer_sum(s : SortcompareintroBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_intro_buffer_mean(s : SortcompareintroBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_intro_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_compare_intro_buffer_scale(s : SortcompareintroBuffer, f : Double) -> SortcompareintroBuffer {
  let result = sort_compare_intro_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_intro_buffer_add(a : SortcompareintroBuffer, b : SortcompareintroBuffer) -> SortcompareintroBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_intro_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_intro_buffer_copy(s : SortcompareintroBuffer) -> SortcompareintroBuffer {
  let result = sort_compare_intro_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_intro_buffer_fill(s : SortcompareintroBuffer, v : Double) -> SortcompareintroBuffer {
  let result = sort_compare_intro_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_buffer_min(s : SortcompareintroBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_buffer_max(s : SortcompareintroBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_buffer_to_string(s : SortcompareintroBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_cursor_make(size : Int) -> SortcompareintroCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_cursor_len(s : SortcompareintroCursor) -> Int { s.size }

pub fn sort_compare_intro_cursor_get(s : SortcompareintroCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_cursor_set(s : SortcompareintroCursor, i : Int, v : Double) -> SortcompareintroCursor {
  let result = sort_compare_intro_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_cursor_sum(s : SortcompareintroCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_intro_cursor_mean(s : SortcompareintroCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_intro_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_compare_intro_cursor_scale(s : SortcompareintroCursor, f : Double) -> SortcompareintroCursor {
  let result = sort_compare_intro_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_intro_cursor_add(a : SortcompareintroCursor, b : SortcompareintroCursor) -> SortcompareintroCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_intro_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_intro_cursor_copy(s : SortcompareintroCursor) -> SortcompareintroCursor {
  let result = sort_compare_intro_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_intro_cursor_fill(s : SortcompareintroCursor, v : Double) -> SortcompareintroCursor {
  let result = sort_compare_intro_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_cursor_min(s : SortcompareintroCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_cursor_max(s : SortcompareintroCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_cursor_to_string(s : SortcompareintroCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_view_make(size : Int) -> SortcompareintroView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_view_len(s : SortcompareintroView) -> Int { s.size }

pub fn sort_compare_intro_view_get(s : SortcompareintroView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_view_set(s : SortcompareintroView, i : Int, v : Double) -> SortcompareintroView {
  let result = sort_compare_intro_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_view_sum(s : SortcompareintroView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_intro_view_mean(s : SortcompareintroView) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_intro_view_sum(s) / s.size.to_double() }
}

pub fn sort_compare_intro_view_scale(s : SortcompareintroView, f : Double) -> SortcompareintroView {
  let result = sort_compare_intro_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_intro_view_add(a : SortcompareintroView, b : SortcompareintroView) -> SortcompareintroView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_intro_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_intro_view_copy(s : SortcompareintroView) -> SortcompareintroView {
  let result = sort_compare_intro_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_intro_view_fill(s : SortcompareintroView, v : Double) -> SortcompareintroView {
  let result = sort_compare_intro_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_view_min(s : SortcompareintroView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_view_max(s : SortcompareintroView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_view_to_string(s : SortcompareintroView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_range_make(size : Int) -> SortcompareintroRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_range_len(s : SortcompareintroRange) -> Int { s.size }

pub fn sort_compare_intro_range_get(s : SortcompareintroRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_range_set(s : SortcompareintroRange, i : Int, v : Double) -> SortcompareintroRange {
  let result = sort_compare_intro_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_range_sum(s : SortcompareintroRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_intro_range_mean(s : SortcompareintroRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_intro_range_sum(s) / s.size.to_double() }
}

pub fn sort_compare_intro_range_scale(s : SortcompareintroRange, f : Double) -> SortcompareintroRange {
  let result = sort_compare_intro_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_intro_range_add(a : SortcompareintroRange, b : SortcompareintroRange) -> SortcompareintroRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_intro_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_intro_range_copy(s : SortcompareintroRange) -> SortcompareintroRange {
  let result = sort_compare_intro_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_intro_range_fill(s : SortcompareintroRange, v : Double) -> SortcompareintroRange {
  let result = sort_compare_intro_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_range_min(s : SortcompareintroRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_range_max(s : SortcompareintroRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_range_to_string(s : SortcompareintroRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_slice_make(size : Int) -> SortcompareintroSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_slice_len(s : SortcompareintroSlice) -> Int { s.size }

pub fn sort_compare_intro_slice_get(s : SortcompareintroSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_slice_set(s : SortcompareintroSlice, i : Int, v : Double) -> SortcompareintroSlice {
  let result = sort_compare_intro_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_slice_sum(s : SortcompareintroSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_intro_slice_mean(s : SortcompareintroSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_intro_slice_sum(s) / s.size.to_double() }
}

pub fn sort_compare_intro_slice_scale(s : SortcompareintroSlice, f : Double) -> SortcompareintroSlice {
  let result = sort_compare_intro_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_intro_slice_add(a : SortcompareintroSlice, b : SortcompareintroSlice) -> SortcompareintroSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_intro_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_intro_slice_copy(s : SortcompareintroSlice) -> SortcompareintroSlice {
  let result = sort_compare_intro_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_intro_slice_fill(s : SortcompareintroSlice, v : Double) -> SortcompareintroSlice {
  let result = sort_compare_intro_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_intro_slice_min(s : SortcompareintroSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_slice_max(s : SortcompareintroSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_intro_slice_to_string(s : SortcompareintroSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

