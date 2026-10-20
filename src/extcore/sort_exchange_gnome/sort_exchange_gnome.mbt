///===
/// extcore/sort_exchange_gnome

pub(all) struct SortexchangegnomePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_gnome_make_point(x : Double, y : Double) -> SortexchangegnomePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_gnome_make_point3(x : Double, y : Double, z : Double) -> SortexchangegnomePoint {
  { x, y, z, label: 0 }
}

pub fn sort_exchange_gnome_point_x(pt : SortexchangegnomePoint) -> Double { pt.x }

pub fn sort_exchange_gnome_point_y(pt : SortexchangegnomePoint) -> Double { pt.y }

pub fn sort_exchange_gnome_point_z(pt : SortexchangegnomePoint) -> Double { pt.z }

pub fn sort_exchange_gnome_point_label(pt : SortexchangegnomePoint) -> Int { pt.label }

pub fn sort_exchange_gnome_point_dist(a : SortexchangegnomePoint, b : SortexchangegnomePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_exchange_gnome_point_add(a : SortexchangegnomePoint, b : SortexchangegnomePoint) -> SortexchangegnomePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_exchange_gnome_point_sub(a : SortexchangegnomePoint, b : SortexchangegnomePoint) -> SortexchangegnomePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_exchange_gnome_point_scale(pt : SortexchangegnomePoint, s : Double) -> SortexchangegnomePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_exchange_gnome_point_dot(a : SortexchangegnomePoint, b : SortexchangegnomePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_exchange_gnome_point_cross(a : SortexchangegnomePoint, b : SortexchangegnomePoint) -> SortexchangegnomePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_exchange_gnome_point_norm(pt : SortexchangegnomePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_exchange_gnome_point_normalize(pt : SortexchangegnomePoint) -> SortexchangegnomePoint {
  let n = sort_exchange_gnome_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_exchange_gnome_point_scale(pt, 1.0 / n) }
}

pub fn sort_exchange_gnome_point_negate(pt : SortexchangegnomePoint) -> SortexchangegnomePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_exchange_gnome_point_mid(a : SortexchangegnomePoint, b : SortexchangegnomePoint) -> SortexchangegnomePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_exchange_gnome_point_lerp(a : SortexchangegnomePoint, b : SortexchangegnomePoint, t : Double) -> SortexchangegnomePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_exchange_gnome_point_to_string(pt : SortexchangegnomePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortexchangegnomeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_gnome_make_series(vals : Array[Double], name : String) -> SortexchangegnomeSeries {
  { vals, name, meta: 0 }
}

pub fn sort_exchange_gnome_series_len(s : SortexchangegnomeSeries) -> Int { s.vals.length() }

pub fn sort_exchange_gnome_series_sum(s : SortexchangegnomeSeries) -> Double { @_common.sum(s.vals) }

pub fn sort_exchange_gnome_series_mean(s : SortexchangegnomeSeries) -> Double { @_common.mean(s.vals) }

pub fn sort_exchange_gnome_series_min(s : SortexchangegnomeSeries) -> Double { @_common.min(s.vals) }

pub fn sort_exchange_gnome_series_max(s : SortexchangegnomeSeries) -> Double { @_common.max(s.vals) }

pub fn sort_exchange_gnome_series_range(s : SortexchangegnomeSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn sort_exchange_gnome_series_var(s : SortexchangegnomeSeries) -> Double { @_common.variance(s.vals) }

pub fn sort_exchange_gnome_series_std(s : SortexchangegnomeSeries) -> Double { @_common.std(s.vals) }

pub fn sort_exchange_gnome_series_median(s : SortexchangegnomeSeries) -> Double { @_common.median(s.vals) }

pub fn sort_exchange_gnome_series_scale(s : SortexchangegnomeSeries, f : Double) -> SortexchangegnomeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_exchange_gnome_series_add(a : SortexchangegnomeSeries, b : SortexchangegnomeSeries) -> SortexchangegnomeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_exchange_gnome_series_sub(a : SortexchangegnomeSeries, b : SortexchangegnomeSeries) -> SortexchangegnomeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_exchange_gnome_series_normalize(s : SortexchangegnomeSeries) -> SortexchangegnomeSeries {
  let mn = sort_exchange_gnome_series_min(s)
  let mx = sort_exchange_gnome_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_exchange_gnome_series_cumsum(s : SortexchangegnomeSeries) -> SortexchangegnomeSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_exchange_gnome_series_to_string(s : SortexchangegnomeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangegnomeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_gnome_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangegnomeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_gnome_matrix_identity(n : Int) -> SortexchangegnomeMatrix {
  let m = sort_exchange_gnome_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_exchange_gnome_matrix_get(m : SortexchangegnomeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_exchange_gnome_matrix_transpose(m : SortexchangegnomeMatrix) -> SortexchangegnomeMatrix {
  let result = sort_exchange_gnome_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_exchange_gnome_matrix_add(a : SortexchangegnomeMatrix, b : SortexchangegnomeMatrix) -> SortexchangegnomeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_exchange_gnome_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_exchange_gnome_matrix_scale(m : SortexchangegnomeMatrix, s : Double) -> SortexchangegnomeMatrix {
  let result = sort_exchange_gnome_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_exchange_gnome_matrix_multiply(a : SortexchangegnomeMatrix, b : SortexchangegnomeMatrix) -> SortexchangegnomeMatrix {
  if a.cols != b.rows { return sort_exchange_gnome_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_exchange_gnome_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_exchange_gnome_matrix_trace(m : SortexchangegnomeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_exchange_gnome_matrix_det(m : SortexchangegnomeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_exchange_gnome_matrix_norm(m : SortexchangegnomeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_exchange_gnome_matrix_to_string(m : SortexchangegnomeMatrix) -> String {
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

pub(all) struct SortexchangegnomeVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_gnome_make_vector(comps : Array[Double]) -> SortexchangegnomeVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_gnome_vector_zero(dim : Int) -> SortexchangegnomeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_exchange_gnome_vector_add(a : SortexchangegnomeVector, b : SortexchangegnomeVector) -> SortexchangegnomeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_exchange_gnome_vector_sub(a : SortexchangegnomeVector, b : SortexchangegnomeVector) -> SortexchangegnomeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_exchange_gnome_vector_scale(v : SortexchangegnomeVector, s : Double) -> SortexchangegnomeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_exchange_gnome_vector_dot(a : SortexchangegnomeVector, b : SortexchangegnomeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_exchange_gnome_vector_norm(v : SortexchangegnomeVector) -> Double { @_common.sqrt(sort_exchange_gnome_vector_dot(v, v)) }

pub fn sort_exchange_gnome_vector_normalize(v : SortexchangegnomeVector) -> SortexchangegnomeVector {
  let n = sort_exchange_gnome_vector_norm(v)
  if n < 0.0000001 { v } else { sort_exchange_gnome_vector_scale(v, 1.0 / n) }
}

pub fn sort_exchange_gnome_vector_dist(a : SortexchangegnomeVector, b : SortexchangegnomeVector) -> Double {
  sort_exchange_gnome_vector_norm(sort_exchange_gnome_vector_sub(a, b))
}

pub fn sort_exchange_gnome_vector_to_string(v : SortexchangegnomeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_exchange_gnome_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_exchange_gnome_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_exchange_gnome_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_exchange_gnome_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_exchange_gnome_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_exchange_gnome_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_exchange_gnome_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_exchange_gnome_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_exchange_gnome_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_exchange_gnome_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_exchange_gnome_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_exchange_gnome_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_exchange_gnome_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_exchange_gnome_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_exchange_gnome_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_exchange_gnome_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_exchange_gnome_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_exchange_gnome_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_exchange_gnome_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_exchange_gnome_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_exchange_gnome_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_exchange_gnome_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_exchange_gnome_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_exchange_gnome_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_exchange_gnome_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_exchange_gnome_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_exchange_gnome_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_exchange_gnome_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_exchange_gnome_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortexchangegnomeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_frame_make(size : Int) -> SortexchangegnomeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_frame_len(s : SortexchangegnomeFrame) -> Int { s.size }

pub fn sort_exchange_gnome_frame_get(s : SortexchangegnomeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_frame_set(s : SortexchangegnomeFrame, i : Int, v : Double) -> SortexchangegnomeFrame {
  let result = sort_exchange_gnome_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_frame_sum(s : SortexchangegnomeFrame) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_frame_mean(s : SortexchangegnomeFrame) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_frame_scale(s : SortexchangegnomeFrame, f : Double) -> SortexchangegnomeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_frame_add(a : SortexchangegnomeFrame, b : SortexchangegnomeFrame) -> SortexchangegnomeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_frame_copy(s : SortexchangegnomeFrame) -> SortexchangegnomeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_frame_fill(s : SortexchangegnomeFrame, v : Double) -> SortexchangegnomeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_frame_min(s : SortexchangegnomeFrame) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_frame_max(s : SortexchangegnomeFrame) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_frame_to_string(s : SortexchangegnomeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_table_make(size : Int) -> SortexchangegnomeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_table_len(s : SortexchangegnomeTable) -> Int { s.size }

pub fn sort_exchange_gnome_table_get(s : SortexchangegnomeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_table_set(s : SortexchangegnomeTable, i : Int, v : Double) -> SortexchangegnomeTable {
  let result = sort_exchange_gnome_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_table_sum(s : SortexchangegnomeTable) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_table_mean(s : SortexchangegnomeTable) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_table_scale(s : SortexchangegnomeTable, f : Double) -> SortexchangegnomeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_table_add(a : SortexchangegnomeTable, b : SortexchangegnomeTable) -> SortexchangegnomeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_table_copy(s : SortexchangegnomeTable) -> SortexchangegnomeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_table_fill(s : SortexchangegnomeTable, v : Double) -> SortexchangegnomeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_table_min(s : SortexchangegnomeTable) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_table_max(s : SortexchangegnomeTable) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_table_to_string(s : SortexchangegnomeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_graphn_make(size : Int) -> SortexchangegnomeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_graphn_len(s : SortexchangegnomeGraphN) -> Int { s.size }

pub fn sort_exchange_gnome_graphn_get(s : SortexchangegnomeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_graphn_set(s : SortexchangegnomeGraphN, i : Int, v : Double) -> SortexchangegnomeGraphN {
  let result = sort_exchange_gnome_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_graphn_sum(s : SortexchangegnomeGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_graphn_mean(s : SortexchangegnomeGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_graphn_scale(s : SortexchangegnomeGraphN, f : Double) -> SortexchangegnomeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_graphn_add(a : SortexchangegnomeGraphN, b : SortexchangegnomeGraphN) -> SortexchangegnomeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_graphn_copy(s : SortexchangegnomeGraphN) -> SortexchangegnomeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_graphn_fill(s : SortexchangegnomeGraphN, v : Double) -> SortexchangegnomeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_graphn_min(s : SortexchangegnomeGraphN) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_graphn_max(s : SortexchangegnomeGraphN) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_graphn_to_string(s : SortexchangegnomeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_node_make(size : Int) -> SortexchangegnomeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_node_len(s : SortexchangegnomeNode) -> Int { s.size }

pub fn sort_exchange_gnome_node_get(s : SortexchangegnomeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_node_set(s : SortexchangegnomeNode, i : Int, v : Double) -> SortexchangegnomeNode {
  let result = sort_exchange_gnome_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_node_sum(s : SortexchangegnomeNode) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_node_mean(s : SortexchangegnomeNode) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_node_scale(s : SortexchangegnomeNode, f : Double) -> SortexchangegnomeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_node_add(a : SortexchangegnomeNode, b : SortexchangegnomeNode) -> SortexchangegnomeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_node_copy(s : SortexchangegnomeNode) -> SortexchangegnomeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_node_fill(s : SortexchangegnomeNode, v : Double) -> SortexchangegnomeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_node_min(s : SortexchangegnomeNode) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_node_max(s : SortexchangegnomeNode) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_node_to_string(s : SortexchangegnomeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_edge_make(size : Int) -> SortexchangegnomeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_edge_len(s : SortexchangegnomeEdge) -> Int { s.size }

pub fn sort_exchange_gnome_edge_get(s : SortexchangegnomeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_edge_set(s : SortexchangegnomeEdge, i : Int, v : Double) -> SortexchangegnomeEdge {
  let result = sort_exchange_gnome_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_edge_sum(s : SortexchangegnomeEdge) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_edge_mean(s : SortexchangegnomeEdge) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_edge_scale(s : SortexchangegnomeEdge, f : Double) -> SortexchangegnomeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_edge_add(a : SortexchangegnomeEdge, b : SortexchangegnomeEdge) -> SortexchangegnomeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_edge_copy(s : SortexchangegnomeEdge) -> SortexchangegnomeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_edge_fill(s : SortexchangegnomeEdge, v : Double) -> SortexchangegnomeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_edge_min(s : SortexchangegnomeEdge) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_edge_max(s : SortexchangegnomeEdge) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_edge_to_string(s : SortexchangegnomeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_path_make(size : Int) -> SortexchangegnomePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_path_len(s : SortexchangegnomePath) -> Int { s.size }

pub fn sort_exchange_gnome_path_get(s : SortexchangegnomePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_path_set(s : SortexchangegnomePath, i : Int, v : Double) -> SortexchangegnomePath {
  let result = sort_exchange_gnome_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_path_sum(s : SortexchangegnomePath) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_path_mean(s : SortexchangegnomePath) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_path_scale(s : SortexchangegnomePath, f : Double) -> SortexchangegnomePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_path_add(a : SortexchangegnomePath, b : SortexchangegnomePath) -> SortexchangegnomePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_path_copy(s : SortexchangegnomePath) -> SortexchangegnomePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_path_fill(s : SortexchangegnomePath, v : Double) -> SortexchangegnomePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_path_min(s : SortexchangegnomePath) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_path_max(s : SortexchangegnomePath) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_path_to_string(s : SortexchangegnomePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_cluster_make(size : Int) -> SortexchangegnomeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_cluster_len(s : SortexchangegnomeCluster) -> Int { s.size }

pub fn sort_exchange_gnome_cluster_get(s : SortexchangegnomeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_cluster_set(s : SortexchangegnomeCluster, i : Int, v : Double) -> SortexchangegnomeCluster {
  let result = sort_exchange_gnome_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_cluster_sum(s : SortexchangegnomeCluster) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_cluster_mean(s : SortexchangegnomeCluster) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_cluster_scale(s : SortexchangegnomeCluster, f : Double) -> SortexchangegnomeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_cluster_add(a : SortexchangegnomeCluster, b : SortexchangegnomeCluster) -> SortexchangegnomeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_cluster_copy(s : SortexchangegnomeCluster) -> SortexchangegnomeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_cluster_fill(s : SortexchangegnomeCluster, v : Double) -> SortexchangegnomeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_cluster_min(s : SortexchangegnomeCluster) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_cluster_max(s : SortexchangegnomeCluster) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_cluster_to_string(s : SortexchangegnomeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_model_make(size : Int) -> SortexchangegnomeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_model_len(s : SortexchangegnomeModel) -> Int { s.size }

pub fn sort_exchange_gnome_model_get(s : SortexchangegnomeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_model_set(s : SortexchangegnomeModel, i : Int, v : Double) -> SortexchangegnomeModel {
  let result = sort_exchange_gnome_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_model_sum(s : SortexchangegnomeModel) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_model_mean(s : SortexchangegnomeModel) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_model_scale(s : SortexchangegnomeModel, f : Double) -> SortexchangegnomeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_model_add(a : SortexchangegnomeModel, b : SortexchangegnomeModel) -> SortexchangegnomeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_model_copy(s : SortexchangegnomeModel) -> SortexchangegnomeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_model_fill(s : SortexchangegnomeModel, v : Double) -> SortexchangegnomeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_model_min(s : SortexchangegnomeModel) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_model_max(s : SortexchangegnomeModel) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_model_to_string(s : SortexchangegnomeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_layer_make(size : Int) -> SortexchangegnomeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_layer_len(s : SortexchangegnomeLayer) -> Int { s.size }

pub fn sort_exchange_gnome_layer_get(s : SortexchangegnomeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_layer_set(s : SortexchangegnomeLayer, i : Int, v : Double) -> SortexchangegnomeLayer {
  let result = sort_exchange_gnome_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_layer_sum(s : SortexchangegnomeLayer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_layer_mean(s : SortexchangegnomeLayer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_layer_scale(s : SortexchangegnomeLayer, f : Double) -> SortexchangegnomeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_layer_add(a : SortexchangegnomeLayer, b : SortexchangegnomeLayer) -> SortexchangegnomeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_layer_copy(s : SortexchangegnomeLayer) -> SortexchangegnomeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_layer_fill(s : SortexchangegnomeLayer, v : Double) -> SortexchangegnomeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_layer_min(s : SortexchangegnomeLayer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_layer_max(s : SortexchangegnomeLayer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_layer_to_string(s : SortexchangegnomeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_buffer_make(size : Int) -> SortexchangegnomeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_buffer_len(s : SortexchangegnomeBuffer) -> Int { s.size }

pub fn sort_exchange_gnome_buffer_get(s : SortexchangegnomeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_buffer_set(s : SortexchangegnomeBuffer, i : Int, v : Double) -> SortexchangegnomeBuffer {
  let result = sort_exchange_gnome_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_buffer_sum(s : SortexchangegnomeBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_buffer_mean(s : SortexchangegnomeBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_buffer_scale(s : SortexchangegnomeBuffer, f : Double) -> SortexchangegnomeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_buffer_add(a : SortexchangegnomeBuffer, b : SortexchangegnomeBuffer) -> SortexchangegnomeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_buffer_copy(s : SortexchangegnomeBuffer) -> SortexchangegnomeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_buffer_fill(s : SortexchangegnomeBuffer, v : Double) -> SortexchangegnomeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_buffer_min(s : SortexchangegnomeBuffer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_buffer_max(s : SortexchangegnomeBuffer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_buffer_to_string(s : SortexchangegnomeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_cursor_make(size : Int) -> SortexchangegnomeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_cursor_len(s : SortexchangegnomeCursor) -> Int { s.size }

pub fn sort_exchange_gnome_cursor_get(s : SortexchangegnomeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_cursor_set(s : SortexchangegnomeCursor, i : Int, v : Double) -> SortexchangegnomeCursor {
  let result = sort_exchange_gnome_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_cursor_sum(s : SortexchangegnomeCursor) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_cursor_mean(s : SortexchangegnomeCursor) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_cursor_scale(s : SortexchangegnomeCursor, f : Double) -> SortexchangegnomeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_cursor_add(a : SortexchangegnomeCursor, b : SortexchangegnomeCursor) -> SortexchangegnomeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_cursor_copy(s : SortexchangegnomeCursor) -> SortexchangegnomeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_cursor_fill(s : SortexchangegnomeCursor, v : Double) -> SortexchangegnomeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_cursor_min(s : SortexchangegnomeCursor) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_cursor_max(s : SortexchangegnomeCursor) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_cursor_to_string(s : SortexchangegnomeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_view_make(size : Int) -> SortexchangegnomeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_view_len(s : SortexchangegnomeView) -> Int { s.size }

pub fn sort_exchange_gnome_view_get(s : SortexchangegnomeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_view_set(s : SortexchangegnomeView, i : Int, v : Double) -> SortexchangegnomeView {
  let result = sort_exchange_gnome_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_view_sum(s : SortexchangegnomeView) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_view_mean(s : SortexchangegnomeView) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_view_scale(s : SortexchangegnomeView, f : Double) -> SortexchangegnomeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_view_add(a : SortexchangegnomeView, b : SortexchangegnomeView) -> SortexchangegnomeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_view_copy(s : SortexchangegnomeView) -> SortexchangegnomeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_view_fill(s : SortexchangegnomeView, v : Double) -> SortexchangegnomeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_view_min(s : SortexchangegnomeView) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_view_max(s : SortexchangegnomeView) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_view_to_string(s : SortexchangegnomeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_range_make(size : Int) -> SortexchangegnomeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_range_len(s : SortexchangegnomeRange) -> Int { s.size }

pub fn sort_exchange_gnome_range_get(s : SortexchangegnomeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_range_set(s : SortexchangegnomeRange, i : Int, v : Double) -> SortexchangegnomeRange {
  let result = sort_exchange_gnome_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_range_sum(s : SortexchangegnomeRange) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_range_mean(s : SortexchangegnomeRange) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_range_scale(s : SortexchangegnomeRange, f : Double) -> SortexchangegnomeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_range_add(a : SortexchangegnomeRange, b : SortexchangegnomeRange) -> SortexchangegnomeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_range_copy(s : SortexchangegnomeRange) -> SortexchangegnomeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_range_fill(s : SortexchangegnomeRange, v : Double) -> SortexchangegnomeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_range_min(s : SortexchangegnomeRange) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_range_max(s : SortexchangegnomeRange) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_range_to_string(s : SortexchangegnomeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_slice_make(size : Int) -> SortexchangegnomeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_slice_len(s : SortexchangegnomeSlice) -> Int { s.size }

pub fn sort_exchange_gnome_slice_get(s : SortexchangegnomeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_slice_set(s : SortexchangegnomeSlice, i : Int, v : Double) -> SortexchangegnomeSlice {
  let result = sort_exchange_gnome_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_slice_sum(s : SortexchangegnomeSlice) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_slice_mean(s : SortexchangegnomeSlice) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_slice_scale(s : SortexchangegnomeSlice, f : Double) -> SortexchangegnomeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_slice_add(a : SortexchangegnomeSlice, b : SortexchangegnomeSlice) -> SortexchangegnomeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_slice_copy(s : SortexchangegnomeSlice) -> SortexchangegnomeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_slice_fill(s : SortexchangegnomeSlice, v : Double) -> SortexchangegnomeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_slice_min(s : SortexchangegnomeSlice) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_slice_max(s : SortexchangegnomeSlice) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_slice_to_string(s : SortexchangegnomeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

