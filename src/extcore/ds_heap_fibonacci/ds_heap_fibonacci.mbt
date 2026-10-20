///===
/// extcore/ds_heap_fibonacci

pub(all) struct DsheapfibonacciPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_fibonacci_make_point(x : Double, y : Double) -> DsheapfibonacciPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_fibonacci_make_point3(x : Double, y : Double, z : Double) -> DsheapfibonacciPoint {
  { x, y, z, label: 0 }
}

pub fn ds_heap_fibonacci_point_x(pt : DsheapfibonacciPoint) -> Double { pt.x }

pub fn ds_heap_fibonacci_point_y(pt : DsheapfibonacciPoint) -> Double { pt.y }

pub fn ds_heap_fibonacci_point_z(pt : DsheapfibonacciPoint) -> Double { pt.z }

pub fn ds_heap_fibonacci_point_label(pt : DsheapfibonacciPoint) -> Int { pt.label }

pub fn ds_heap_fibonacci_point_dist(a : DsheapfibonacciPoint, b : DsheapfibonacciPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_heap_fibonacci_point_add(a : DsheapfibonacciPoint, b : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_heap_fibonacci_point_sub(a : DsheapfibonacciPoint, b : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_heap_fibonacci_point_scale(pt : DsheapfibonacciPoint, s : Double) -> DsheapfibonacciPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_heap_fibonacci_point_dot(a : DsheapfibonacciPoint, b : DsheapfibonacciPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_heap_fibonacci_point_cross(a : DsheapfibonacciPoint, b : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_heap_fibonacci_point_norm(pt : DsheapfibonacciPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_heap_fibonacci_point_normalize(pt : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  let n = ds_heap_fibonacci_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_heap_fibonacci_point_scale(pt, 1.0 / n) }
}

pub fn ds_heap_fibonacci_point_negate(pt : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_heap_fibonacci_point_mid(a : DsheapfibonacciPoint, b : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_heap_fibonacci_point_lerp(a : DsheapfibonacciPoint, b : DsheapfibonacciPoint, t : Double) -> DsheapfibonacciPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_heap_fibonacci_point_to_string(pt : DsheapfibonacciPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsheapfibonacciSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_fibonacci_make_series(vals : Array[Double], name : String) -> DsheapfibonacciSeries {
  { vals, name, meta: 0 }
}

pub fn ds_heap_fibonacci_series_len(s : DsheapfibonacciSeries) -> Int { s.vals.length() }

pub fn ds_heap_fibonacci_series_sum(s : DsheapfibonacciSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_heap_fibonacci_series_mean(s : DsheapfibonacciSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_heap_fibonacci_series_min(s : DsheapfibonacciSeries) -> Double { @_common.min(s.vals) }

pub fn ds_heap_fibonacci_series_max(s : DsheapfibonacciSeries) -> Double { @_common.max(s.vals) }

pub fn ds_heap_fibonacci_series_range(s : DsheapfibonacciSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_heap_fibonacci_series_var(s : DsheapfibonacciSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_heap_fibonacci_series_std(s : DsheapfibonacciSeries) -> Double { @_common.std(s.vals) }

pub fn ds_heap_fibonacci_series_median(s : DsheapfibonacciSeries) -> Double { @_common.median(s.vals) }

pub fn ds_heap_fibonacci_series_scale(s : DsheapfibonacciSeries, f : Double) -> DsheapfibonacciSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn ds_heap_fibonacci_series_add(a : DsheapfibonacciSeries, b : DsheapfibonacciSeries) -> DsheapfibonacciSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_heap_fibonacci_series_sub(a : DsheapfibonacciSeries, b : DsheapfibonacciSeries) -> DsheapfibonacciSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_heap_fibonacci_series_normalize(s : DsheapfibonacciSeries) -> DsheapfibonacciSeries {
  let mn = ds_heap_fibonacci_series_min(s)
  let mx = ds_heap_fibonacci_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_heap_fibonacci_series_cumsum(s : DsheapfibonacciSeries) -> DsheapfibonacciSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_heap_fibonacci_series_to_string(s : DsheapfibonacciSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapfibonacciMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_fibonacci_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapfibonacciMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_fibonacci_matrix_identity(n : Int) -> DsheapfibonacciMatrix {
  let m = ds_heap_fibonacci_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_heap_fibonacci_matrix_get(m : DsheapfibonacciMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_heap_fibonacci_matrix_transpose(m : DsheapfibonacciMatrix) -> DsheapfibonacciMatrix {
  let result = ds_heap_fibonacci_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_heap_fibonacci_matrix_add(a : DsheapfibonacciMatrix, b : DsheapfibonacciMatrix) -> DsheapfibonacciMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_heap_fibonacci_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_heap_fibonacci_matrix_scale(m : DsheapfibonacciMatrix, s : Double) -> DsheapfibonacciMatrix {
  let result = ds_heap_fibonacci_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_heap_fibonacci_matrix_multiply(a : DsheapfibonacciMatrix, b : DsheapfibonacciMatrix) -> DsheapfibonacciMatrix {
  if a.cols != b.rows { return ds_heap_fibonacci_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_heap_fibonacci_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_heap_fibonacci_matrix_trace(m : DsheapfibonacciMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_heap_fibonacci_matrix_det(m : DsheapfibonacciMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_heap_fibonacci_matrix_norm(m : DsheapfibonacciMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_heap_fibonacci_matrix_to_string(m : DsheapfibonacciMatrix) -> String {
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

pub(all) struct DsheapfibonacciVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_fibonacci_make_vector(comps : Array[Double]) -> DsheapfibonacciVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_fibonacci_vector_zero(dim : Int) -> DsheapfibonacciVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_heap_fibonacci_vector_add(a : DsheapfibonacciVector, b : DsheapfibonacciVector) -> DsheapfibonacciVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn ds_heap_fibonacci_vector_sub(a : DsheapfibonacciVector, b : DsheapfibonacciVector) -> DsheapfibonacciVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn ds_heap_fibonacci_vector_scale(v : DsheapfibonacciVector, s : Double) -> DsheapfibonacciVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn ds_heap_fibonacci_vector_dot(a : DsheapfibonacciVector, b : DsheapfibonacciVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_heap_fibonacci_vector_norm(v : DsheapfibonacciVector) -> Double { @_common.sqrt(ds_heap_fibonacci_vector_dot(v, v)) }

pub fn ds_heap_fibonacci_vector_normalize(v : DsheapfibonacciVector) -> DsheapfibonacciVector {
  let n = ds_heap_fibonacci_vector_norm(v)
  if n < 0.0000001 { v } else { ds_heap_fibonacci_vector_scale(v, 1.0 / n) }
}

pub fn ds_heap_fibonacci_vector_dist(a : DsheapfibonacciVector, b : DsheapfibonacciVector) -> Double {
  ds_heap_fibonacci_vector_norm(ds_heap_fibonacci_vector_sub(a, b))
}

pub fn ds_heap_fibonacci_vector_to_string(v : DsheapfibonacciVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_fibonacci_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_heap_fibonacci_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_heap_fibonacci_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_heap_fibonacci_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_heap_fibonacci_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_heap_fibonacci_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_heap_fibonacci_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_heap_fibonacci_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_heap_fibonacci_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_heap_fibonacci_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_heap_fibonacci_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_heap_fibonacci_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_heap_fibonacci_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_heap_fibonacci_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_heap_fibonacci_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_heap_fibonacci_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_heap_fibonacci_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_heap_fibonacci_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_heap_fibonacci_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_heap_fibonacci_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_heap_fibonacci_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_heap_fibonacci_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_heap_fibonacci_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_heap_fibonacci_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_heap_fibonacci_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_heap_fibonacci_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_heap_fibonacci_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_heap_fibonacci_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_heap_fibonacci_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsheapfibonacciFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_frame_make(size : Int) -> DsheapfibonacciFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_frame_len(s : DsheapfibonacciFrame) -> Int { s.size }

pub fn ds_heap_fibonacci_frame_get(s : DsheapfibonacciFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_frame_set(s : DsheapfibonacciFrame, i : Int, v : Double) -> DsheapfibonacciFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_frame_sum(s : DsheapfibonacciFrame) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_frame_mean(s : DsheapfibonacciFrame) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_frame_scale(s : DsheapfibonacciFrame, f : Double) -> DsheapfibonacciFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_frame_add(a : DsheapfibonacciFrame, b : DsheapfibonacciFrame) -> DsheapfibonacciFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_frame_copy(s : DsheapfibonacciFrame) -> DsheapfibonacciFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_frame_fill(s : DsheapfibonacciFrame, v : Double) -> DsheapfibonacciFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_frame_min(s : DsheapfibonacciFrame) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_frame_max(s : DsheapfibonacciFrame) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_frame_to_string(s : DsheapfibonacciFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_table_make(size : Int) -> DsheapfibonacciTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_table_len(s : DsheapfibonacciTable) -> Int { s.size }

pub fn ds_heap_fibonacci_table_get(s : DsheapfibonacciTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_table_set(s : DsheapfibonacciTable, i : Int, v : Double) -> DsheapfibonacciTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_table_sum(s : DsheapfibonacciTable) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_table_mean(s : DsheapfibonacciTable) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_table_scale(s : DsheapfibonacciTable, f : Double) -> DsheapfibonacciTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_table_add(a : DsheapfibonacciTable, b : DsheapfibonacciTable) -> DsheapfibonacciTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_table_copy(s : DsheapfibonacciTable) -> DsheapfibonacciTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_table_fill(s : DsheapfibonacciTable, v : Double) -> DsheapfibonacciTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_table_min(s : DsheapfibonacciTable) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_table_max(s : DsheapfibonacciTable) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_table_to_string(s : DsheapfibonacciTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_graphn_make(size : Int) -> DsheapfibonacciGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_graphn_len(s : DsheapfibonacciGraphN) -> Int { s.size }

pub fn ds_heap_fibonacci_graphn_get(s : DsheapfibonacciGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_graphn_set(s : DsheapfibonacciGraphN, i : Int, v : Double) -> DsheapfibonacciGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_graphn_sum(s : DsheapfibonacciGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_graphn_mean(s : DsheapfibonacciGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_graphn_scale(s : DsheapfibonacciGraphN, f : Double) -> DsheapfibonacciGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_graphn_add(a : DsheapfibonacciGraphN, b : DsheapfibonacciGraphN) -> DsheapfibonacciGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_graphn_copy(s : DsheapfibonacciGraphN) -> DsheapfibonacciGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_graphn_fill(s : DsheapfibonacciGraphN, v : Double) -> DsheapfibonacciGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_graphn_min(s : DsheapfibonacciGraphN) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_graphn_max(s : DsheapfibonacciGraphN) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_graphn_to_string(s : DsheapfibonacciGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_node_make(size : Int) -> DsheapfibonacciNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_node_len(s : DsheapfibonacciNode) -> Int { s.size }

pub fn ds_heap_fibonacci_node_get(s : DsheapfibonacciNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_node_set(s : DsheapfibonacciNode, i : Int, v : Double) -> DsheapfibonacciNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_node_sum(s : DsheapfibonacciNode) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_node_mean(s : DsheapfibonacciNode) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_node_scale(s : DsheapfibonacciNode, f : Double) -> DsheapfibonacciNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_node_add(a : DsheapfibonacciNode, b : DsheapfibonacciNode) -> DsheapfibonacciNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_node_copy(s : DsheapfibonacciNode) -> DsheapfibonacciNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_node_fill(s : DsheapfibonacciNode, v : Double) -> DsheapfibonacciNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_node_min(s : DsheapfibonacciNode) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_node_max(s : DsheapfibonacciNode) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_node_to_string(s : DsheapfibonacciNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_edge_make(size : Int) -> DsheapfibonacciEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_edge_len(s : DsheapfibonacciEdge) -> Int { s.size }

pub fn ds_heap_fibonacci_edge_get(s : DsheapfibonacciEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_edge_set(s : DsheapfibonacciEdge, i : Int, v : Double) -> DsheapfibonacciEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_edge_sum(s : DsheapfibonacciEdge) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_edge_mean(s : DsheapfibonacciEdge) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_edge_scale(s : DsheapfibonacciEdge, f : Double) -> DsheapfibonacciEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_edge_add(a : DsheapfibonacciEdge, b : DsheapfibonacciEdge) -> DsheapfibonacciEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_edge_copy(s : DsheapfibonacciEdge) -> DsheapfibonacciEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_edge_fill(s : DsheapfibonacciEdge, v : Double) -> DsheapfibonacciEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_edge_min(s : DsheapfibonacciEdge) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_edge_max(s : DsheapfibonacciEdge) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_edge_to_string(s : DsheapfibonacciEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_path_make(size : Int) -> DsheapfibonacciPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_path_len(s : DsheapfibonacciPath) -> Int { s.size }

pub fn ds_heap_fibonacci_path_get(s : DsheapfibonacciPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_path_set(s : DsheapfibonacciPath, i : Int, v : Double) -> DsheapfibonacciPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_path_sum(s : DsheapfibonacciPath) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_path_mean(s : DsheapfibonacciPath) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_path_scale(s : DsheapfibonacciPath, f : Double) -> DsheapfibonacciPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_path_add(a : DsheapfibonacciPath, b : DsheapfibonacciPath) -> DsheapfibonacciPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_path_copy(s : DsheapfibonacciPath) -> DsheapfibonacciPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_path_fill(s : DsheapfibonacciPath, v : Double) -> DsheapfibonacciPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_path_min(s : DsheapfibonacciPath) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_path_max(s : DsheapfibonacciPath) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_path_to_string(s : DsheapfibonacciPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_cluster_make(size : Int) -> DsheapfibonacciCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_cluster_len(s : DsheapfibonacciCluster) -> Int { s.size }

pub fn ds_heap_fibonacci_cluster_get(s : DsheapfibonacciCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_cluster_set(s : DsheapfibonacciCluster, i : Int, v : Double) -> DsheapfibonacciCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_cluster_sum(s : DsheapfibonacciCluster) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_cluster_mean(s : DsheapfibonacciCluster) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_cluster_scale(s : DsheapfibonacciCluster, f : Double) -> DsheapfibonacciCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_cluster_add(a : DsheapfibonacciCluster, b : DsheapfibonacciCluster) -> DsheapfibonacciCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_cluster_copy(s : DsheapfibonacciCluster) -> DsheapfibonacciCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_cluster_fill(s : DsheapfibonacciCluster, v : Double) -> DsheapfibonacciCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_cluster_min(s : DsheapfibonacciCluster) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_cluster_max(s : DsheapfibonacciCluster) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_cluster_to_string(s : DsheapfibonacciCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_model_make(size : Int) -> DsheapfibonacciModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_model_len(s : DsheapfibonacciModel) -> Int { s.size }

pub fn ds_heap_fibonacci_model_get(s : DsheapfibonacciModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_model_set(s : DsheapfibonacciModel, i : Int, v : Double) -> DsheapfibonacciModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_model_sum(s : DsheapfibonacciModel) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_model_mean(s : DsheapfibonacciModel) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_model_scale(s : DsheapfibonacciModel, f : Double) -> DsheapfibonacciModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_model_add(a : DsheapfibonacciModel, b : DsheapfibonacciModel) -> DsheapfibonacciModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_model_copy(s : DsheapfibonacciModel) -> DsheapfibonacciModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_model_fill(s : DsheapfibonacciModel, v : Double) -> DsheapfibonacciModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_model_min(s : DsheapfibonacciModel) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_model_max(s : DsheapfibonacciModel) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_model_to_string(s : DsheapfibonacciModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_layer_make(size : Int) -> DsheapfibonacciLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_layer_len(s : DsheapfibonacciLayer) -> Int { s.size }

pub fn ds_heap_fibonacci_layer_get(s : DsheapfibonacciLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_layer_set(s : DsheapfibonacciLayer, i : Int, v : Double) -> DsheapfibonacciLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_layer_sum(s : DsheapfibonacciLayer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_layer_mean(s : DsheapfibonacciLayer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_layer_scale(s : DsheapfibonacciLayer, f : Double) -> DsheapfibonacciLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_layer_add(a : DsheapfibonacciLayer, b : DsheapfibonacciLayer) -> DsheapfibonacciLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_layer_copy(s : DsheapfibonacciLayer) -> DsheapfibonacciLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_layer_fill(s : DsheapfibonacciLayer, v : Double) -> DsheapfibonacciLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_layer_min(s : DsheapfibonacciLayer) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_layer_max(s : DsheapfibonacciLayer) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_layer_to_string(s : DsheapfibonacciLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_buffer_make(size : Int) -> DsheapfibonacciBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_buffer_len(s : DsheapfibonacciBuffer) -> Int { s.size }

pub fn ds_heap_fibonacci_buffer_get(s : DsheapfibonacciBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_buffer_set(s : DsheapfibonacciBuffer, i : Int, v : Double) -> DsheapfibonacciBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_buffer_sum(s : DsheapfibonacciBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_buffer_mean(s : DsheapfibonacciBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_buffer_scale(s : DsheapfibonacciBuffer, f : Double) -> DsheapfibonacciBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_buffer_add(a : DsheapfibonacciBuffer, b : DsheapfibonacciBuffer) -> DsheapfibonacciBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_buffer_copy(s : DsheapfibonacciBuffer) -> DsheapfibonacciBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_buffer_fill(s : DsheapfibonacciBuffer, v : Double) -> DsheapfibonacciBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_buffer_min(s : DsheapfibonacciBuffer) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_buffer_max(s : DsheapfibonacciBuffer) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_buffer_to_string(s : DsheapfibonacciBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_cursor_make(size : Int) -> DsheapfibonacciCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_cursor_len(s : DsheapfibonacciCursor) -> Int { s.size }

pub fn ds_heap_fibonacci_cursor_get(s : DsheapfibonacciCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_cursor_set(s : DsheapfibonacciCursor, i : Int, v : Double) -> DsheapfibonacciCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_cursor_sum(s : DsheapfibonacciCursor) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_cursor_mean(s : DsheapfibonacciCursor) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_cursor_scale(s : DsheapfibonacciCursor, f : Double) -> DsheapfibonacciCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_cursor_add(a : DsheapfibonacciCursor, b : DsheapfibonacciCursor) -> DsheapfibonacciCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_cursor_copy(s : DsheapfibonacciCursor) -> DsheapfibonacciCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_cursor_fill(s : DsheapfibonacciCursor, v : Double) -> DsheapfibonacciCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_cursor_min(s : DsheapfibonacciCursor) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_cursor_max(s : DsheapfibonacciCursor) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_cursor_to_string(s : DsheapfibonacciCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_view_make(size : Int) -> DsheapfibonacciView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_view_len(s : DsheapfibonacciView) -> Int { s.size }

pub fn ds_heap_fibonacci_view_get(s : DsheapfibonacciView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_view_set(s : DsheapfibonacciView, i : Int, v : Double) -> DsheapfibonacciView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_view_sum(s : DsheapfibonacciView) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_view_mean(s : DsheapfibonacciView) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_view_scale(s : DsheapfibonacciView, f : Double) -> DsheapfibonacciView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_view_add(a : DsheapfibonacciView, b : DsheapfibonacciView) -> DsheapfibonacciView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_view_copy(s : DsheapfibonacciView) -> DsheapfibonacciView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_view_fill(s : DsheapfibonacciView, v : Double) -> DsheapfibonacciView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_view_min(s : DsheapfibonacciView) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_view_max(s : DsheapfibonacciView) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_view_to_string(s : DsheapfibonacciView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_range_make(size : Int) -> DsheapfibonacciRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_range_len(s : DsheapfibonacciRange) -> Int { s.size }

pub fn ds_heap_fibonacci_range_get(s : DsheapfibonacciRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_range_set(s : DsheapfibonacciRange, i : Int, v : Double) -> DsheapfibonacciRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_range_sum(s : DsheapfibonacciRange) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_range_mean(s : DsheapfibonacciRange) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_range_scale(s : DsheapfibonacciRange, f : Double) -> DsheapfibonacciRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_range_add(a : DsheapfibonacciRange, b : DsheapfibonacciRange) -> DsheapfibonacciRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_range_copy(s : DsheapfibonacciRange) -> DsheapfibonacciRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_range_fill(s : DsheapfibonacciRange, v : Double) -> DsheapfibonacciRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_range_min(s : DsheapfibonacciRange) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_range_max(s : DsheapfibonacciRange) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_range_to_string(s : DsheapfibonacciRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_slice_make(size : Int) -> DsheapfibonacciSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_slice_len(s : DsheapfibonacciSlice) -> Int { s.size }

pub fn ds_heap_fibonacci_slice_get(s : DsheapfibonacciSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_slice_set(s : DsheapfibonacciSlice, i : Int, v : Double) -> DsheapfibonacciSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_slice_sum(s : DsheapfibonacciSlice) -> Double { @_common.sum(s.data) }

pub fn ds_heap_fibonacci_slice_mean(s : DsheapfibonacciSlice) -> Double { @_common.mean(s.data) }

pub fn ds_heap_fibonacci_slice_scale(s : DsheapfibonacciSlice, f : Double) -> DsheapfibonacciSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_slice_add(a : DsheapfibonacciSlice, b : DsheapfibonacciSlice) -> DsheapfibonacciSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_fibonacci_slice_copy(s : DsheapfibonacciSlice) -> DsheapfibonacciSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_slice_fill(s : DsheapfibonacciSlice, v : Double) -> DsheapfibonacciSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_fibonacci_slice_min(s : DsheapfibonacciSlice) -> Double { @_common.min(s.data) }

pub fn ds_heap_fibonacci_slice_max(s : DsheapfibonacciSlice) -> Double { @_common.max(s.data) }

pub fn ds_heap_fibonacci_slice_to_string(s : DsheapfibonacciSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

