///===
/// extcore/ds_heap_binomial

pub(all) struct DsheapbinomialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_binomial_make_point(x : Double, y : Double) -> DsheapbinomialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_binomial_make_point3(x : Double, y : Double, z : Double) -> DsheapbinomialPoint {
  { x, y, z, label: 0 }
}

pub fn ds_heap_binomial_point_x(pt : DsheapbinomialPoint) -> Double { pt.x }

pub fn ds_heap_binomial_point_y(pt : DsheapbinomialPoint) -> Double { pt.y }

pub fn ds_heap_binomial_point_z(pt : DsheapbinomialPoint) -> Double { pt.z }

pub fn ds_heap_binomial_point_label(pt : DsheapbinomialPoint) -> Int { pt.label }

pub fn ds_heap_binomial_point_dist(a : DsheapbinomialPoint, b : DsheapbinomialPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_heap_binomial_point_add(a : DsheapbinomialPoint, b : DsheapbinomialPoint) -> DsheapbinomialPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_heap_binomial_point_sub(a : DsheapbinomialPoint, b : DsheapbinomialPoint) -> DsheapbinomialPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_heap_binomial_point_scale(pt : DsheapbinomialPoint, s : Double) -> DsheapbinomialPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_heap_binomial_point_dot(a : DsheapbinomialPoint, b : DsheapbinomialPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_heap_binomial_point_cross(a : DsheapbinomialPoint, b : DsheapbinomialPoint) -> DsheapbinomialPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_heap_binomial_point_norm(pt : DsheapbinomialPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_heap_binomial_point_normalize(pt : DsheapbinomialPoint) -> DsheapbinomialPoint {
  let n = ds_heap_binomial_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_heap_binomial_point_scale(pt, 1.0 / n) }
}

pub fn ds_heap_binomial_point_negate(pt : DsheapbinomialPoint) -> DsheapbinomialPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_heap_binomial_point_mid(a : DsheapbinomialPoint, b : DsheapbinomialPoint) -> DsheapbinomialPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_heap_binomial_point_lerp(a : DsheapbinomialPoint, b : DsheapbinomialPoint, t : Double) -> DsheapbinomialPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_heap_binomial_point_to_string(pt : DsheapbinomialPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsheapbinomialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_binomial_make_series(vals : Array[Double], name : String) -> DsheapbinomialSeries {
  { vals, name, meta: 0 }
}

pub fn ds_heap_binomial_series_len(s : DsheapbinomialSeries) -> Int { s.vals.length() }

pub fn ds_heap_binomial_series_sum(s : DsheapbinomialSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_heap_binomial_series_mean(s : DsheapbinomialSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_heap_binomial_series_min(s : DsheapbinomialSeries) -> Double { @_common.min(s.vals) }

pub fn ds_heap_binomial_series_max(s : DsheapbinomialSeries) -> Double { @_common.max(s.vals) }

pub fn ds_heap_binomial_series_range(s : DsheapbinomialSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_heap_binomial_series_var(s : DsheapbinomialSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_heap_binomial_series_std(s : DsheapbinomialSeries) -> Double { @_common.std(s.vals) }

pub fn ds_heap_binomial_series_median(s : DsheapbinomialSeries) -> Double { @_common.median(s.vals) }

pub fn ds_heap_binomial_series_scale(s : DsheapbinomialSeries, f : Double) -> DsheapbinomialSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn ds_heap_binomial_series_add(a : DsheapbinomialSeries, b : DsheapbinomialSeries) -> DsheapbinomialSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_heap_binomial_series_sub(a : DsheapbinomialSeries, b : DsheapbinomialSeries) -> DsheapbinomialSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_heap_binomial_series_normalize(s : DsheapbinomialSeries) -> DsheapbinomialSeries {
  let mn = ds_heap_binomial_series_min(s)
  let mx = ds_heap_binomial_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_heap_binomial_series_cumsum(s : DsheapbinomialSeries) -> DsheapbinomialSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_heap_binomial_series_to_string(s : DsheapbinomialSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapbinomialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_binomial_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapbinomialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_binomial_matrix_identity(n : Int) -> DsheapbinomialMatrix {
  let m = ds_heap_binomial_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_heap_binomial_matrix_get(m : DsheapbinomialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_heap_binomial_matrix_transpose(m : DsheapbinomialMatrix) -> DsheapbinomialMatrix {
  let result = ds_heap_binomial_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_heap_binomial_matrix_add(a : DsheapbinomialMatrix, b : DsheapbinomialMatrix) -> DsheapbinomialMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_heap_binomial_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_heap_binomial_matrix_scale(m : DsheapbinomialMatrix, s : Double) -> DsheapbinomialMatrix {
  let result = ds_heap_binomial_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_heap_binomial_matrix_multiply(a : DsheapbinomialMatrix, b : DsheapbinomialMatrix) -> DsheapbinomialMatrix {
  if a.cols != b.rows { return ds_heap_binomial_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_heap_binomial_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_heap_binomial_matrix_trace(m : DsheapbinomialMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_heap_binomial_matrix_det(m : DsheapbinomialMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_heap_binomial_matrix_norm(m : DsheapbinomialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_heap_binomial_matrix_to_string(m : DsheapbinomialMatrix) -> String {
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

pub(all) struct DsheapbinomialVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_binomial_make_vector(comps : Array[Double]) -> DsheapbinomialVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_binomial_vector_zero(dim : Int) -> DsheapbinomialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_heap_binomial_vector_add(a : DsheapbinomialVector, b : DsheapbinomialVector) -> DsheapbinomialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn ds_heap_binomial_vector_sub(a : DsheapbinomialVector, b : DsheapbinomialVector) -> DsheapbinomialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn ds_heap_binomial_vector_scale(v : DsheapbinomialVector, s : Double) -> DsheapbinomialVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn ds_heap_binomial_vector_dot(a : DsheapbinomialVector, b : DsheapbinomialVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_heap_binomial_vector_norm(v : DsheapbinomialVector) -> Double { @_common.sqrt(ds_heap_binomial_vector_dot(v, v)) }

pub fn ds_heap_binomial_vector_normalize(v : DsheapbinomialVector) -> DsheapbinomialVector {
  let n = ds_heap_binomial_vector_norm(v)
  if n < 0.0000001 { v } else { ds_heap_binomial_vector_scale(v, 1.0 / n) }
}

pub fn ds_heap_binomial_vector_dist(a : DsheapbinomialVector, b : DsheapbinomialVector) -> Double {
  ds_heap_binomial_vector_norm(ds_heap_binomial_vector_sub(a, b))
}

pub fn ds_heap_binomial_vector_to_string(v : DsheapbinomialVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_binomial_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_heap_binomial_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_heap_binomial_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_heap_binomial_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_heap_binomial_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_heap_binomial_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_heap_binomial_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_heap_binomial_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_heap_binomial_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_heap_binomial_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_heap_binomial_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_heap_binomial_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_heap_binomial_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_heap_binomial_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_heap_binomial_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_heap_binomial_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_heap_binomial_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_heap_binomial_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_heap_binomial_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_heap_binomial_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_heap_binomial_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_heap_binomial_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_heap_binomial_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_heap_binomial_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_heap_binomial_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_heap_binomial_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_heap_binomial_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_heap_binomial_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_heap_binomial_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsheapbinomialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_frame_make(size : Int) -> DsheapbinomialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_frame_len(s : DsheapbinomialFrame) -> Int { s.size }

pub fn ds_heap_binomial_frame_get(s : DsheapbinomialFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_frame_set(s : DsheapbinomialFrame, i : Int, v : Double) -> DsheapbinomialFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_frame_sum(s : DsheapbinomialFrame) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_frame_mean(s : DsheapbinomialFrame) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_frame_scale(s : DsheapbinomialFrame, f : Double) -> DsheapbinomialFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_frame_add(a : DsheapbinomialFrame, b : DsheapbinomialFrame) -> DsheapbinomialFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_frame_copy(s : DsheapbinomialFrame) -> DsheapbinomialFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_frame_fill(s : DsheapbinomialFrame, v : Double) -> DsheapbinomialFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_frame_min(s : DsheapbinomialFrame) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_frame_max(s : DsheapbinomialFrame) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_frame_to_string(s : DsheapbinomialFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_table_make(size : Int) -> DsheapbinomialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_table_len(s : DsheapbinomialTable) -> Int { s.size }

pub fn ds_heap_binomial_table_get(s : DsheapbinomialTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_table_set(s : DsheapbinomialTable, i : Int, v : Double) -> DsheapbinomialTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_table_sum(s : DsheapbinomialTable) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_table_mean(s : DsheapbinomialTable) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_table_scale(s : DsheapbinomialTable, f : Double) -> DsheapbinomialTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_table_add(a : DsheapbinomialTable, b : DsheapbinomialTable) -> DsheapbinomialTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_table_copy(s : DsheapbinomialTable) -> DsheapbinomialTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_table_fill(s : DsheapbinomialTable, v : Double) -> DsheapbinomialTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_table_min(s : DsheapbinomialTable) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_table_max(s : DsheapbinomialTable) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_table_to_string(s : DsheapbinomialTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_graphn_make(size : Int) -> DsheapbinomialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_graphn_len(s : DsheapbinomialGraphN) -> Int { s.size }

pub fn ds_heap_binomial_graphn_get(s : DsheapbinomialGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_graphn_set(s : DsheapbinomialGraphN, i : Int, v : Double) -> DsheapbinomialGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_graphn_sum(s : DsheapbinomialGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_graphn_mean(s : DsheapbinomialGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_graphn_scale(s : DsheapbinomialGraphN, f : Double) -> DsheapbinomialGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_graphn_add(a : DsheapbinomialGraphN, b : DsheapbinomialGraphN) -> DsheapbinomialGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_graphn_copy(s : DsheapbinomialGraphN) -> DsheapbinomialGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_graphn_fill(s : DsheapbinomialGraphN, v : Double) -> DsheapbinomialGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_graphn_min(s : DsheapbinomialGraphN) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_graphn_max(s : DsheapbinomialGraphN) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_graphn_to_string(s : DsheapbinomialGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_node_make(size : Int) -> DsheapbinomialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_node_len(s : DsheapbinomialNode) -> Int { s.size }

pub fn ds_heap_binomial_node_get(s : DsheapbinomialNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_node_set(s : DsheapbinomialNode, i : Int, v : Double) -> DsheapbinomialNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_node_sum(s : DsheapbinomialNode) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_node_mean(s : DsheapbinomialNode) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_node_scale(s : DsheapbinomialNode, f : Double) -> DsheapbinomialNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_node_add(a : DsheapbinomialNode, b : DsheapbinomialNode) -> DsheapbinomialNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_node_copy(s : DsheapbinomialNode) -> DsheapbinomialNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_node_fill(s : DsheapbinomialNode, v : Double) -> DsheapbinomialNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_node_min(s : DsheapbinomialNode) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_node_max(s : DsheapbinomialNode) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_node_to_string(s : DsheapbinomialNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_edge_make(size : Int) -> DsheapbinomialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_edge_len(s : DsheapbinomialEdge) -> Int { s.size }

pub fn ds_heap_binomial_edge_get(s : DsheapbinomialEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_edge_set(s : DsheapbinomialEdge, i : Int, v : Double) -> DsheapbinomialEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_edge_sum(s : DsheapbinomialEdge) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_edge_mean(s : DsheapbinomialEdge) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_edge_scale(s : DsheapbinomialEdge, f : Double) -> DsheapbinomialEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_edge_add(a : DsheapbinomialEdge, b : DsheapbinomialEdge) -> DsheapbinomialEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_edge_copy(s : DsheapbinomialEdge) -> DsheapbinomialEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_edge_fill(s : DsheapbinomialEdge, v : Double) -> DsheapbinomialEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_edge_min(s : DsheapbinomialEdge) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_edge_max(s : DsheapbinomialEdge) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_edge_to_string(s : DsheapbinomialEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_path_make(size : Int) -> DsheapbinomialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_path_len(s : DsheapbinomialPath) -> Int { s.size }

pub fn ds_heap_binomial_path_get(s : DsheapbinomialPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_path_set(s : DsheapbinomialPath, i : Int, v : Double) -> DsheapbinomialPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_path_sum(s : DsheapbinomialPath) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_path_mean(s : DsheapbinomialPath) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_path_scale(s : DsheapbinomialPath, f : Double) -> DsheapbinomialPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_path_add(a : DsheapbinomialPath, b : DsheapbinomialPath) -> DsheapbinomialPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_path_copy(s : DsheapbinomialPath) -> DsheapbinomialPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_path_fill(s : DsheapbinomialPath, v : Double) -> DsheapbinomialPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_path_min(s : DsheapbinomialPath) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_path_max(s : DsheapbinomialPath) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_path_to_string(s : DsheapbinomialPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_cluster_make(size : Int) -> DsheapbinomialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_cluster_len(s : DsheapbinomialCluster) -> Int { s.size }

pub fn ds_heap_binomial_cluster_get(s : DsheapbinomialCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_cluster_set(s : DsheapbinomialCluster, i : Int, v : Double) -> DsheapbinomialCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_cluster_sum(s : DsheapbinomialCluster) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_cluster_mean(s : DsheapbinomialCluster) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_cluster_scale(s : DsheapbinomialCluster, f : Double) -> DsheapbinomialCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_cluster_add(a : DsheapbinomialCluster, b : DsheapbinomialCluster) -> DsheapbinomialCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_cluster_copy(s : DsheapbinomialCluster) -> DsheapbinomialCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_cluster_fill(s : DsheapbinomialCluster, v : Double) -> DsheapbinomialCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_cluster_min(s : DsheapbinomialCluster) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_cluster_max(s : DsheapbinomialCluster) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_cluster_to_string(s : DsheapbinomialCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_model_make(size : Int) -> DsheapbinomialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_model_len(s : DsheapbinomialModel) -> Int { s.size }

pub fn ds_heap_binomial_model_get(s : DsheapbinomialModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_model_set(s : DsheapbinomialModel, i : Int, v : Double) -> DsheapbinomialModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_model_sum(s : DsheapbinomialModel) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_model_mean(s : DsheapbinomialModel) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_model_scale(s : DsheapbinomialModel, f : Double) -> DsheapbinomialModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_model_add(a : DsheapbinomialModel, b : DsheapbinomialModel) -> DsheapbinomialModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_model_copy(s : DsheapbinomialModel) -> DsheapbinomialModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_model_fill(s : DsheapbinomialModel, v : Double) -> DsheapbinomialModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_model_min(s : DsheapbinomialModel) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_model_max(s : DsheapbinomialModel) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_model_to_string(s : DsheapbinomialModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_layer_make(size : Int) -> DsheapbinomialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_layer_len(s : DsheapbinomialLayer) -> Int { s.size }

pub fn ds_heap_binomial_layer_get(s : DsheapbinomialLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_layer_set(s : DsheapbinomialLayer, i : Int, v : Double) -> DsheapbinomialLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_layer_sum(s : DsheapbinomialLayer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_layer_mean(s : DsheapbinomialLayer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_layer_scale(s : DsheapbinomialLayer, f : Double) -> DsheapbinomialLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_layer_add(a : DsheapbinomialLayer, b : DsheapbinomialLayer) -> DsheapbinomialLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_layer_copy(s : DsheapbinomialLayer) -> DsheapbinomialLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_layer_fill(s : DsheapbinomialLayer, v : Double) -> DsheapbinomialLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_layer_min(s : DsheapbinomialLayer) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_layer_max(s : DsheapbinomialLayer) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_layer_to_string(s : DsheapbinomialLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_buffer_make(size : Int) -> DsheapbinomialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_buffer_len(s : DsheapbinomialBuffer) -> Int { s.size }

pub fn ds_heap_binomial_buffer_get(s : DsheapbinomialBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_buffer_set(s : DsheapbinomialBuffer, i : Int, v : Double) -> DsheapbinomialBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_buffer_sum(s : DsheapbinomialBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_buffer_mean(s : DsheapbinomialBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_buffer_scale(s : DsheapbinomialBuffer, f : Double) -> DsheapbinomialBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_buffer_add(a : DsheapbinomialBuffer, b : DsheapbinomialBuffer) -> DsheapbinomialBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_buffer_copy(s : DsheapbinomialBuffer) -> DsheapbinomialBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_buffer_fill(s : DsheapbinomialBuffer, v : Double) -> DsheapbinomialBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_buffer_min(s : DsheapbinomialBuffer) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_buffer_max(s : DsheapbinomialBuffer) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_buffer_to_string(s : DsheapbinomialBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_cursor_make(size : Int) -> DsheapbinomialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_cursor_len(s : DsheapbinomialCursor) -> Int { s.size }

pub fn ds_heap_binomial_cursor_get(s : DsheapbinomialCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_cursor_set(s : DsheapbinomialCursor, i : Int, v : Double) -> DsheapbinomialCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_cursor_sum(s : DsheapbinomialCursor) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_cursor_mean(s : DsheapbinomialCursor) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_cursor_scale(s : DsheapbinomialCursor, f : Double) -> DsheapbinomialCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_cursor_add(a : DsheapbinomialCursor, b : DsheapbinomialCursor) -> DsheapbinomialCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_cursor_copy(s : DsheapbinomialCursor) -> DsheapbinomialCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_cursor_fill(s : DsheapbinomialCursor, v : Double) -> DsheapbinomialCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_cursor_min(s : DsheapbinomialCursor) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_cursor_max(s : DsheapbinomialCursor) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_cursor_to_string(s : DsheapbinomialCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_view_make(size : Int) -> DsheapbinomialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_view_len(s : DsheapbinomialView) -> Int { s.size }

pub fn ds_heap_binomial_view_get(s : DsheapbinomialView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_view_set(s : DsheapbinomialView, i : Int, v : Double) -> DsheapbinomialView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_view_sum(s : DsheapbinomialView) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_view_mean(s : DsheapbinomialView) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_view_scale(s : DsheapbinomialView, f : Double) -> DsheapbinomialView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_view_add(a : DsheapbinomialView, b : DsheapbinomialView) -> DsheapbinomialView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_view_copy(s : DsheapbinomialView) -> DsheapbinomialView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_view_fill(s : DsheapbinomialView, v : Double) -> DsheapbinomialView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_view_min(s : DsheapbinomialView) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_view_max(s : DsheapbinomialView) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_view_to_string(s : DsheapbinomialView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_range_make(size : Int) -> DsheapbinomialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_range_len(s : DsheapbinomialRange) -> Int { s.size }

pub fn ds_heap_binomial_range_get(s : DsheapbinomialRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_range_set(s : DsheapbinomialRange, i : Int, v : Double) -> DsheapbinomialRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_range_sum(s : DsheapbinomialRange) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_range_mean(s : DsheapbinomialRange) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_range_scale(s : DsheapbinomialRange, f : Double) -> DsheapbinomialRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_range_add(a : DsheapbinomialRange, b : DsheapbinomialRange) -> DsheapbinomialRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_range_copy(s : DsheapbinomialRange) -> DsheapbinomialRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_range_fill(s : DsheapbinomialRange, v : Double) -> DsheapbinomialRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_range_min(s : DsheapbinomialRange) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_range_max(s : DsheapbinomialRange) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_range_to_string(s : DsheapbinomialRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinomialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binomial_slice_make(size : Int) -> DsheapbinomialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binomial_slice_len(s : DsheapbinomialSlice) -> Int { s.size }

pub fn ds_heap_binomial_slice_get(s : DsheapbinomialSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binomial_slice_set(s : DsheapbinomialSlice, i : Int, v : Double) -> DsheapbinomialSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_slice_sum(s : DsheapbinomialSlice) -> Double { @_common.sum(s.data) }

pub fn ds_heap_binomial_slice_mean(s : DsheapbinomialSlice) -> Double { @_common.mean(s.data) }

pub fn ds_heap_binomial_slice_scale(s : DsheapbinomialSlice, f : Double) -> DsheapbinomialSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_slice_add(a : DsheapbinomialSlice, b : DsheapbinomialSlice) -> DsheapbinomialSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_binomial_slice_copy(s : DsheapbinomialSlice) -> DsheapbinomialSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_slice_fill(s : DsheapbinomialSlice, v : Double) -> DsheapbinomialSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_binomial_slice_min(s : DsheapbinomialSlice) -> Double { @_common.min(s.data) }

pub fn ds_heap_binomial_slice_max(s : DsheapbinomialSlice) -> Double { @_common.max(s.data) }

pub fn ds_heap_binomial_slice_to_string(s : DsheapbinomialSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

