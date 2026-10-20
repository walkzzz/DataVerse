///===
/// extcore/ds_heap_skew

pub(all) struct DsheapskewPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_skew_make_point(x : Double, y : Double) -> DsheapskewPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_skew_make_point3(x : Double, y : Double, z : Double) -> DsheapskewPoint {
  { x, y, z, label: 0 }
}

pub fn ds_heap_skew_point_x(pt : DsheapskewPoint) -> Double { pt.x }

pub fn ds_heap_skew_point_y(pt : DsheapskewPoint) -> Double { pt.y }

pub fn ds_heap_skew_point_z(pt : DsheapskewPoint) -> Double { pt.z }

pub fn ds_heap_skew_point_label(pt : DsheapskewPoint) -> Int { pt.label }

pub fn ds_heap_skew_point_dist(a : DsheapskewPoint, b : DsheapskewPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_heap_skew_point_add(a : DsheapskewPoint, b : DsheapskewPoint) -> DsheapskewPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_heap_skew_point_sub(a : DsheapskewPoint, b : DsheapskewPoint) -> DsheapskewPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_heap_skew_point_scale(pt : DsheapskewPoint, s : Double) -> DsheapskewPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_heap_skew_point_dot(a : DsheapskewPoint, b : DsheapskewPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_heap_skew_point_cross(a : DsheapskewPoint, b : DsheapskewPoint) -> DsheapskewPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_heap_skew_point_norm(pt : DsheapskewPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_heap_skew_point_normalize(pt : DsheapskewPoint) -> DsheapskewPoint {
  let n = ds_heap_skew_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_heap_skew_point_scale(pt, 1.0 / n) }
}

pub fn ds_heap_skew_point_negate(pt : DsheapskewPoint) -> DsheapskewPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_heap_skew_point_mid(a : DsheapskewPoint, b : DsheapskewPoint) -> DsheapskewPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_heap_skew_point_lerp(a : DsheapskewPoint, b : DsheapskewPoint, t : Double) -> DsheapskewPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_heap_skew_point_to_string(pt : DsheapskewPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsheapskewSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_skew_make_series(vals : Array[Double], name : String) -> DsheapskewSeries {
  { vals, name, meta: 0 }
}

pub fn ds_heap_skew_series_len(s : DsheapskewSeries) -> Int { s.vals.length() }

pub fn ds_heap_skew_series_sum(s : DsheapskewSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_heap_skew_series_mean(s : DsheapskewSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_heap_skew_series_min(s : DsheapskewSeries) -> Double { @_common.min(s.vals) }

pub fn ds_heap_skew_series_max(s : DsheapskewSeries) -> Double { @_common.max(s.vals) }

pub fn ds_heap_skew_series_range(s : DsheapskewSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_heap_skew_series_var(s : DsheapskewSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_heap_skew_series_std(s : DsheapskewSeries) -> Double { @_common.std(s.vals) }

pub fn ds_heap_skew_series_median(s : DsheapskewSeries) -> Double { @_common.median(s.vals) }

pub fn ds_heap_skew_series_scale(s : DsheapskewSeries, f : Double) -> DsheapskewSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_heap_skew_series_add(a : DsheapskewSeries, b : DsheapskewSeries) -> DsheapskewSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_heap_skew_series_sub(a : DsheapskewSeries, b : DsheapskewSeries) -> DsheapskewSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_heap_skew_series_normalize(s : DsheapskewSeries) -> DsheapskewSeries {
  let mn = ds_heap_skew_series_min(s)
  let mx = ds_heap_skew_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_heap_skew_series_cumsum(s : DsheapskewSeries) -> DsheapskewSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_heap_skew_series_to_string(s : DsheapskewSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapskewMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_skew_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapskewMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_skew_matrix_identity(n : Int) -> DsheapskewMatrix {
  let m = ds_heap_skew_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_heap_skew_matrix_get(m : DsheapskewMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_heap_skew_matrix_transpose(m : DsheapskewMatrix) -> DsheapskewMatrix {
  let result = ds_heap_skew_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_heap_skew_matrix_add(a : DsheapskewMatrix, b : DsheapskewMatrix) -> DsheapskewMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_heap_skew_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_heap_skew_matrix_scale(m : DsheapskewMatrix, s : Double) -> DsheapskewMatrix {
  let result = ds_heap_skew_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_heap_skew_matrix_multiply(a : DsheapskewMatrix, b : DsheapskewMatrix) -> DsheapskewMatrix {
  if a.cols != b.rows { return ds_heap_skew_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_heap_skew_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_heap_skew_matrix_trace(m : DsheapskewMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_heap_skew_matrix_det(m : DsheapskewMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_heap_skew_matrix_norm(m : DsheapskewMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_heap_skew_matrix_to_string(m : DsheapskewMatrix) -> String {
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

pub(all) struct DsheapskewVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_skew_make_vector(comps : Array[Double]) -> DsheapskewVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_skew_vector_zero(dim : Int) -> DsheapskewVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_heap_skew_vector_add(a : DsheapskewVector, b : DsheapskewVector) -> DsheapskewVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_heap_skew_vector_sub(a : DsheapskewVector, b : DsheapskewVector) -> DsheapskewVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_heap_skew_vector_scale(v : DsheapskewVector, s : Double) -> DsheapskewVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_heap_skew_vector_dot(a : DsheapskewVector, b : DsheapskewVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_heap_skew_vector_norm(v : DsheapskewVector) -> Double { @_common.sqrt(ds_heap_skew_vector_dot(v, v)) }

pub fn ds_heap_skew_vector_normalize(v : DsheapskewVector) -> DsheapskewVector {
  let n = ds_heap_skew_vector_norm(v)
  if n < 0.0000001 { v } else { ds_heap_skew_vector_scale(v, 1.0 / n) }
}

pub fn ds_heap_skew_vector_dist(a : DsheapskewVector, b : DsheapskewVector) -> Double {
  ds_heap_skew_vector_norm(ds_heap_skew_vector_sub(a, b))
}

pub fn ds_heap_skew_vector_to_string(v : DsheapskewVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_skew_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_heap_skew_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_heap_skew_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_heap_skew_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_heap_skew_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_heap_skew_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_heap_skew_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_heap_skew_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_heap_skew_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_heap_skew_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_heap_skew_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_heap_skew_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_heap_skew_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_heap_skew_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_heap_skew_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_heap_skew_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_heap_skew_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_heap_skew_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_heap_skew_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_heap_skew_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_heap_skew_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_heap_skew_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_heap_skew_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_heap_skew_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_heap_skew_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_heap_skew_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_heap_skew_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_heap_skew_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_heap_skew_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsheapskewFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_frame_make(size : Int) -> DsheapskewFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_frame_len(s : DsheapskewFrame) -> Int { s.size }

pub fn ds_heap_skew_frame_get(s : DsheapskewFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_frame_set(s : DsheapskewFrame, i : Int, v : Double) -> DsheapskewFrame {
  let result = ds_heap_skew_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_skew_frame_sum(s : DsheapskewFrame) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_frame_mean(s : DsheapskewFrame) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_frame_scale(s : DsheapskewFrame, f : Double) -> DsheapskewFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_frame_add(a : DsheapskewFrame, b : DsheapskewFrame) -> DsheapskewFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_frame_copy(s : DsheapskewFrame) -> DsheapskewFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_frame_fill(s : DsheapskewFrame, v : Double) -> DsheapskewFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_frame_min(s : DsheapskewFrame) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_frame_max(s : DsheapskewFrame) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_frame_to_string(s : DsheapskewFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_table_make(size : Int) -> DsheapskewTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_table_len(s : DsheapskewTable) -> Int { s.size }

pub fn ds_heap_skew_table_get(s : DsheapskewTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_table_set(s : DsheapskewTable, i : Int, v : Double) -> DsheapskewTable {
  let result = ds_heap_skew_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_skew_table_sum(s : DsheapskewTable) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_table_mean(s : DsheapskewTable) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_table_scale(s : DsheapskewTable, f : Double) -> DsheapskewTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_table_add(a : DsheapskewTable, b : DsheapskewTable) -> DsheapskewTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_table_copy(s : DsheapskewTable) -> DsheapskewTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_table_fill(s : DsheapskewTable, v : Double) -> DsheapskewTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_table_min(s : DsheapskewTable) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_table_max(s : DsheapskewTable) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_table_to_string(s : DsheapskewTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_graphn_make(size : Int) -> DsheapskewGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_graphn_len(s : DsheapskewGraphN) -> Int { s.size }

pub fn ds_heap_skew_graphn_get(s : DsheapskewGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_graphn_set(s : DsheapskewGraphN, i : Int, v : Double) -> DsheapskewGraphN {
  let result = ds_heap_skew_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_skew_graphn_sum(s : DsheapskewGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_graphn_mean(s : DsheapskewGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_graphn_scale(s : DsheapskewGraphN, f : Double) -> DsheapskewGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_graphn_add(a : DsheapskewGraphN, b : DsheapskewGraphN) -> DsheapskewGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_graphn_copy(s : DsheapskewGraphN) -> DsheapskewGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_graphn_fill(s : DsheapskewGraphN, v : Double) -> DsheapskewGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_graphn_min(s : DsheapskewGraphN) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_graphn_max(s : DsheapskewGraphN) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_graphn_to_string(s : DsheapskewGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_node_make(size : Int) -> DsheapskewNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_node_len(s : DsheapskewNode) -> Int { s.size }

pub fn ds_heap_skew_node_get(s : DsheapskewNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_node_set(s : DsheapskewNode, i : Int, v : Double) -> DsheapskewNode {
  let result = ds_heap_skew_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_skew_node_sum(s : DsheapskewNode) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_node_mean(s : DsheapskewNode) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_node_scale(s : DsheapskewNode, f : Double) -> DsheapskewNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_node_add(a : DsheapskewNode, b : DsheapskewNode) -> DsheapskewNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_node_copy(s : DsheapskewNode) -> DsheapskewNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_node_fill(s : DsheapskewNode, v : Double) -> DsheapskewNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_node_min(s : DsheapskewNode) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_node_max(s : DsheapskewNode) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_node_to_string(s : DsheapskewNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_edge_make(size : Int) -> DsheapskewEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_edge_len(s : DsheapskewEdge) -> Int { s.size }

pub fn ds_heap_skew_edge_get(s : DsheapskewEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_edge_set(s : DsheapskewEdge, i : Int, v : Double) -> DsheapskewEdge {
  let result = ds_heap_skew_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_skew_edge_sum(s : DsheapskewEdge) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_edge_mean(s : DsheapskewEdge) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_edge_scale(s : DsheapskewEdge, f : Double) -> DsheapskewEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_edge_add(a : DsheapskewEdge, b : DsheapskewEdge) -> DsheapskewEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_edge_copy(s : DsheapskewEdge) -> DsheapskewEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_edge_fill(s : DsheapskewEdge, v : Double) -> DsheapskewEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_edge_min(s : DsheapskewEdge) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_edge_max(s : DsheapskewEdge) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_edge_to_string(s : DsheapskewEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_path_make(size : Int) -> DsheapskewPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_path_len(s : DsheapskewPath) -> Int { s.size }

pub fn ds_heap_skew_path_get(s : DsheapskewPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_path_set(s : DsheapskewPath, i : Int, v : Double) -> DsheapskewPath {
  let result = ds_heap_skew_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_skew_path_sum(s : DsheapskewPath) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_path_mean(s : DsheapskewPath) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_path_scale(s : DsheapskewPath, f : Double) -> DsheapskewPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_path_add(a : DsheapskewPath, b : DsheapskewPath) -> DsheapskewPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_path_copy(s : DsheapskewPath) -> DsheapskewPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_path_fill(s : DsheapskewPath, v : Double) -> DsheapskewPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_path_min(s : DsheapskewPath) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_path_max(s : DsheapskewPath) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_path_to_string(s : DsheapskewPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_cluster_make(size : Int) -> DsheapskewCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_cluster_len(s : DsheapskewCluster) -> Int { s.size }

pub fn ds_heap_skew_cluster_get(s : DsheapskewCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_cluster_set(s : DsheapskewCluster, i : Int, v : Double) -> DsheapskewCluster {
  let result = ds_heap_skew_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_skew_cluster_sum(s : DsheapskewCluster) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_cluster_mean(s : DsheapskewCluster) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_cluster_scale(s : DsheapskewCluster, f : Double) -> DsheapskewCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_cluster_add(a : DsheapskewCluster, b : DsheapskewCluster) -> DsheapskewCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_cluster_copy(s : DsheapskewCluster) -> DsheapskewCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_cluster_fill(s : DsheapskewCluster, v : Double) -> DsheapskewCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_cluster_min(s : DsheapskewCluster) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_cluster_max(s : DsheapskewCluster) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_cluster_to_string(s : DsheapskewCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_model_make(size : Int) -> DsheapskewModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_model_len(s : DsheapskewModel) -> Int { s.size }

pub fn ds_heap_skew_model_get(s : DsheapskewModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_model_set(s : DsheapskewModel, i : Int, v : Double) -> DsheapskewModel {
  let result = ds_heap_skew_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_skew_model_sum(s : DsheapskewModel) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_model_mean(s : DsheapskewModel) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_model_scale(s : DsheapskewModel, f : Double) -> DsheapskewModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_model_add(a : DsheapskewModel, b : DsheapskewModel) -> DsheapskewModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_model_copy(s : DsheapskewModel) -> DsheapskewModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_model_fill(s : DsheapskewModel, v : Double) -> DsheapskewModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_model_min(s : DsheapskewModel) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_model_max(s : DsheapskewModel) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_model_to_string(s : DsheapskewModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_layer_make(size : Int) -> DsheapskewLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_layer_len(s : DsheapskewLayer) -> Int { s.size }

pub fn ds_heap_skew_layer_get(s : DsheapskewLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_layer_set(s : DsheapskewLayer, i : Int, v : Double) -> DsheapskewLayer {
  let result = ds_heap_skew_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_skew_layer_sum(s : DsheapskewLayer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_layer_mean(s : DsheapskewLayer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_layer_scale(s : DsheapskewLayer, f : Double) -> DsheapskewLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_layer_add(a : DsheapskewLayer, b : DsheapskewLayer) -> DsheapskewLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_layer_copy(s : DsheapskewLayer) -> DsheapskewLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_layer_fill(s : DsheapskewLayer, v : Double) -> DsheapskewLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_layer_min(s : DsheapskewLayer) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_layer_max(s : DsheapskewLayer) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_layer_to_string(s : DsheapskewLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_buffer_make(size : Int) -> DsheapskewBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_buffer_len(s : DsheapskewBuffer) -> Int { s.size }

pub fn ds_heap_skew_buffer_get(s : DsheapskewBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_buffer_set(s : DsheapskewBuffer, i : Int, v : Double) -> DsheapskewBuffer {
  let result = ds_heap_skew_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_skew_buffer_sum(s : DsheapskewBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_buffer_mean(s : DsheapskewBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_buffer_scale(s : DsheapskewBuffer, f : Double) -> DsheapskewBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_buffer_add(a : DsheapskewBuffer, b : DsheapskewBuffer) -> DsheapskewBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_buffer_copy(s : DsheapskewBuffer) -> DsheapskewBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_buffer_fill(s : DsheapskewBuffer, v : Double) -> DsheapskewBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_buffer_min(s : DsheapskewBuffer) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_buffer_max(s : DsheapskewBuffer) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_buffer_to_string(s : DsheapskewBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_cursor_make(size : Int) -> DsheapskewCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_cursor_len(s : DsheapskewCursor) -> Int { s.size }

pub fn ds_heap_skew_cursor_get(s : DsheapskewCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_cursor_set(s : DsheapskewCursor, i : Int, v : Double) -> DsheapskewCursor {
  let result = ds_heap_skew_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_skew_cursor_sum(s : DsheapskewCursor) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_cursor_mean(s : DsheapskewCursor) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_cursor_scale(s : DsheapskewCursor, f : Double) -> DsheapskewCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_cursor_add(a : DsheapskewCursor, b : DsheapskewCursor) -> DsheapskewCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_cursor_copy(s : DsheapskewCursor) -> DsheapskewCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_cursor_fill(s : DsheapskewCursor, v : Double) -> DsheapskewCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_cursor_min(s : DsheapskewCursor) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_cursor_max(s : DsheapskewCursor) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_cursor_to_string(s : DsheapskewCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_view_make(size : Int) -> DsheapskewView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_view_len(s : DsheapskewView) -> Int { s.size }

pub fn ds_heap_skew_view_get(s : DsheapskewView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_view_set(s : DsheapskewView, i : Int, v : Double) -> DsheapskewView {
  let result = ds_heap_skew_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_skew_view_sum(s : DsheapskewView) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_view_mean(s : DsheapskewView) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_view_scale(s : DsheapskewView, f : Double) -> DsheapskewView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_view_add(a : DsheapskewView, b : DsheapskewView) -> DsheapskewView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_view_copy(s : DsheapskewView) -> DsheapskewView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_view_fill(s : DsheapskewView, v : Double) -> DsheapskewView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_view_min(s : DsheapskewView) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_view_max(s : DsheapskewView) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_view_to_string(s : DsheapskewView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_range_make(size : Int) -> DsheapskewRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_range_len(s : DsheapskewRange) -> Int { s.size }

pub fn ds_heap_skew_range_get(s : DsheapskewRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_range_set(s : DsheapskewRange, i : Int, v : Double) -> DsheapskewRange {
  let result = ds_heap_skew_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_skew_range_sum(s : DsheapskewRange) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_range_mean(s : DsheapskewRange) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_range_scale(s : DsheapskewRange, f : Double) -> DsheapskewRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_range_add(a : DsheapskewRange, b : DsheapskewRange) -> DsheapskewRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_range_copy(s : DsheapskewRange) -> DsheapskewRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_range_fill(s : DsheapskewRange, v : Double) -> DsheapskewRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_range_min(s : DsheapskewRange) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_range_max(s : DsheapskewRange) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_range_to_string(s : DsheapskewRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_slice_make(size : Int) -> DsheapskewSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_slice_len(s : DsheapskewSlice) -> Int { s.size }

pub fn ds_heap_skew_slice_get(s : DsheapskewSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_slice_set(s : DsheapskewSlice, i : Int, v : Double) -> DsheapskewSlice {
  let result = ds_heap_skew_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_skew_slice_sum(s : DsheapskewSlice) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_slice_mean(s : DsheapskewSlice) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_slice_scale(s : DsheapskewSlice, f : Double) -> DsheapskewSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_slice_add(a : DsheapskewSlice, b : DsheapskewSlice) -> DsheapskewSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_slice_copy(s : DsheapskewSlice) -> DsheapskewSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_slice_fill(s : DsheapskewSlice, v : Double) -> DsheapskewSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_slice_min(s : DsheapskewSlice) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_slice_max(s : DsheapskewSlice) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_slice_to_string(s : DsheapskewSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

