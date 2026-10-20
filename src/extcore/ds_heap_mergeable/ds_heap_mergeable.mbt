///===
/// extcore/ds_heap_mergeable

pub(all) struct DsheapmergeablePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_mergeable_make_point(x : Double, y : Double) -> DsheapmergeablePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_mergeable_make_point3(x : Double, y : Double, z : Double) -> DsheapmergeablePoint {
  { x, y, z, label: 0 }
}

pub fn ds_heap_mergeable_point_x(pt : DsheapmergeablePoint) -> Double { pt.x }

pub fn ds_heap_mergeable_point_y(pt : DsheapmergeablePoint) -> Double { pt.y }

pub fn ds_heap_mergeable_point_z(pt : DsheapmergeablePoint) -> Double { pt.z }

pub fn ds_heap_mergeable_point_label(pt : DsheapmergeablePoint) -> Int { pt.label }

pub fn ds_heap_mergeable_point_dist(a : DsheapmergeablePoint, b : DsheapmergeablePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_heap_mergeable_point_add(a : DsheapmergeablePoint, b : DsheapmergeablePoint) -> DsheapmergeablePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_heap_mergeable_point_sub(a : DsheapmergeablePoint, b : DsheapmergeablePoint) -> DsheapmergeablePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_heap_mergeable_point_scale(pt : DsheapmergeablePoint, s : Double) -> DsheapmergeablePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_heap_mergeable_point_dot(a : DsheapmergeablePoint, b : DsheapmergeablePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_heap_mergeable_point_cross(a : DsheapmergeablePoint, b : DsheapmergeablePoint) -> DsheapmergeablePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_heap_mergeable_point_norm(pt : DsheapmergeablePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_heap_mergeable_point_normalize(pt : DsheapmergeablePoint) -> DsheapmergeablePoint {
  let n = ds_heap_mergeable_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_heap_mergeable_point_scale(pt, 1.0 / n) }
}

pub fn ds_heap_mergeable_point_negate(pt : DsheapmergeablePoint) -> DsheapmergeablePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_heap_mergeable_point_mid(a : DsheapmergeablePoint, b : DsheapmergeablePoint) -> DsheapmergeablePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_heap_mergeable_point_lerp(a : DsheapmergeablePoint, b : DsheapmergeablePoint, t : Double) -> DsheapmergeablePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_heap_mergeable_point_to_string(pt : DsheapmergeablePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsheapmergeableSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_mergeable_make_series(vals : Array[Double], name : String) -> DsheapmergeableSeries {
  { vals, name, meta: 0 }
}

pub fn ds_heap_mergeable_series_len(s : DsheapmergeableSeries) -> Int { s.vals.length() }

pub fn ds_heap_mergeable_series_sum(s : DsheapmergeableSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_heap_mergeable_series_mean(s : DsheapmergeableSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_heap_mergeable_series_min(s : DsheapmergeableSeries) -> Double { @_common.min(s.vals) }

pub fn ds_heap_mergeable_series_max(s : DsheapmergeableSeries) -> Double { @_common.max(s.vals) }

pub fn ds_heap_mergeable_series_range(s : DsheapmergeableSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_heap_mergeable_series_var(s : DsheapmergeableSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_heap_mergeable_series_std(s : DsheapmergeableSeries) -> Double { @_common.std(s.vals) }

pub fn ds_heap_mergeable_series_median(s : DsheapmergeableSeries) -> Double { @_common.median(s.vals) }

pub fn ds_heap_mergeable_series_scale(s : DsheapmergeableSeries, f : Double) -> DsheapmergeableSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_heap_mergeable_series_add(a : DsheapmergeableSeries, b : DsheapmergeableSeries) -> DsheapmergeableSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_heap_mergeable_series_sub(a : DsheapmergeableSeries, b : DsheapmergeableSeries) -> DsheapmergeableSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_heap_mergeable_series_normalize(s : DsheapmergeableSeries) -> DsheapmergeableSeries {
  let mn = ds_heap_mergeable_series_min(s)
  let mx = ds_heap_mergeable_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_heap_mergeable_series_cumsum(s : DsheapmergeableSeries) -> DsheapmergeableSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_heap_mergeable_series_to_string(s : DsheapmergeableSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapmergeableMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_mergeable_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapmergeableMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_mergeable_matrix_identity(n : Int) -> DsheapmergeableMatrix {
  let m = ds_heap_mergeable_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_heap_mergeable_matrix_get(m : DsheapmergeableMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_heap_mergeable_matrix_transpose(m : DsheapmergeableMatrix) -> DsheapmergeableMatrix {
  let result = ds_heap_mergeable_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_heap_mergeable_matrix_add(a : DsheapmergeableMatrix, b : DsheapmergeableMatrix) -> DsheapmergeableMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_heap_mergeable_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_heap_mergeable_matrix_scale(m : DsheapmergeableMatrix, s : Double) -> DsheapmergeableMatrix {
  let result = ds_heap_mergeable_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_heap_mergeable_matrix_multiply(a : DsheapmergeableMatrix, b : DsheapmergeableMatrix) -> DsheapmergeableMatrix {
  if a.cols != b.rows { return ds_heap_mergeable_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_heap_mergeable_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_heap_mergeable_matrix_trace(m : DsheapmergeableMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_heap_mergeable_matrix_det(m : DsheapmergeableMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_heap_mergeable_matrix_norm(m : DsheapmergeableMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_heap_mergeable_matrix_to_string(m : DsheapmergeableMatrix) -> String {
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

pub(all) struct DsheapmergeableVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_mergeable_make_vector(comps : Array[Double]) -> DsheapmergeableVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_mergeable_vector_zero(dim : Int) -> DsheapmergeableVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_heap_mergeable_vector_add(a : DsheapmergeableVector, b : DsheapmergeableVector) -> DsheapmergeableVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_heap_mergeable_vector_sub(a : DsheapmergeableVector, b : DsheapmergeableVector) -> DsheapmergeableVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_heap_mergeable_vector_scale(v : DsheapmergeableVector, s : Double) -> DsheapmergeableVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_heap_mergeable_vector_dot(a : DsheapmergeableVector, b : DsheapmergeableVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_heap_mergeable_vector_norm(v : DsheapmergeableVector) -> Double { @_common.sqrt(ds_heap_mergeable_vector_dot(v, v)) }

pub fn ds_heap_mergeable_vector_normalize(v : DsheapmergeableVector) -> DsheapmergeableVector {
  let n = ds_heap_mergeable_vector_norm(v)
  if n < 0.0000001 { v } else { ds_heap_mergeable_vector_scale(v, 1.0 / n) }
}

pub fn ds_heap_mergeable_vector_dist(a : DsheapmergeableVector, b : DsheapmergeableVector) -> Double {
  ds_heap_mergeable_vector_norm(ds_heap_mergeable_vector_sub(a, b))
}

pub fn ds_heap_mergeable_vector_to_string(v : DsheapmergeableVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_mergeable_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_heap_mergeable_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_heap_mergeable_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_heap_mergeable_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_heap_mergeable_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_heap_mergeable_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_heap_mergeable_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_heap_mergeable_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_heap_mergeable_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_heap_mergeable_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_heap_mergeable_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_heap_mergeable_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_heap_mergeable_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_heap_mergeable_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_heap_mergeable_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_heap_mergeable_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_heap_mergeable_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_heap_mergeable_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_heap_mergeable_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_heap_mergeable_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_heap_mergeable_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_heap_mergeable_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_heap_mergeable_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_heap_mergeable_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_heap_mergeable_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_heap_mergeable_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_heap_mergeable_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_heap_mergeable_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_heap_mergeable_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsheapmergeableFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_frame_make(size : Int) -> DsheapmergeableFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_frame_len(s : DsheapmergeableFrame) -> Int { s.size }

pub fn ds_heap_mergeable_frame_get(s : DsheapmergeableFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_frame_set(s : DsheapmergeableFrame, i : Int, v : Double) -> DsheapmergeableFrame {
  let result = ds_heap_mergeable_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_frame_sum(s : DsheapmergeableFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_mergeable_frame_mean(s : DsheapmergeableFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_mergeable_frame_sum(s) / s.size.to_double() }
}

pub fn ds_heap_mergeable_frame_scale(s : DsheapmergeableFrame, f : Double) -> DsheapmergeableFrame {
  let result = ds_heap_mergeable_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_mergeable_frame_add(a : DsheapmergeableFrame, b : DsheapmergeableFrame) -> DsheapmergeableFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_mergeable_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_mergeable_frame_copy(s : DsheapmergeableFrame) -> DsheapmergeableFrame {
  let result = ds_heap_mergeable_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_mergeable_frame_fill(s : DsheapmergeableFrame, v : Double) -> DsheapmergeableFrame {
  let result = ds_heap_mergeable_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_frame_min(s : DsheapmergeableFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_frame_max(s : DsheapmergeableFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_frame_to_string(s : DsheapmergeableFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_table_make(size : Int) -> DsheapmergeableTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_table_len(s : DsheapmergeableTable) -> Int { s.size }

pub fn ds_heap_mergeable_table_get(s : DsheapmergeableTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_table_set(s : DsheapmergeableTable, i : Int, v : Double) -> DsheapmergeableTable {
  let result = ds_heap_mergeable_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_table_sum(s : DsheapmergeableTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_mergeable_table_mean(s : DsheapmergeableTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_mergeable_table_sum(s) / s.size.to_double() }
}

pub fn ds_heap_mergeable_table_scale(s : DsheapmergeableTable, f : Double) -> DsheapmergeableTable {
  let result = ds_heap_mergeable_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_mergeable_table_add(a : DsheapmergeableTable, b : DsheapmergeableTable) -> DsheapmergeableTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_mergeable_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_mergeable_table_copy(s : DsheapmergeableTable) -> DsheapmergeableTable {
  let result = ds_heap_mergeable_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_mergeable_table_fill(s : DsheapmergeableTable, v : Double) -> DsheapmergeableTable {
  let result = ds_heap_mergeable_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_table_min(s : DsheapmergeableTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_table_max(s : DsheapmergeableTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_table_to_string(s : DsheapmergeableTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_graphn_make(size : Int) -> DsheapmergeableGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_graphn_len(s : DsheapmergeableGraphN) -> Int { s.size }

pub fn ds_heap_mergeable_graphn_get(s : DsheapmergeableGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_graphn_set(s : DsheapmergeableGraphN, i : Int, v : Double) -> DsheapmergeableGraphN {
  let result = ds_heap_mergeable_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_graphn_sum(s : DsheapmergeableGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_mergeable_graphn_mean(s : DsheapmergeableGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_mergeable_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_heap_mergeable_graphn_scale(s : DsheapmergeableGraphN, f : Double) -> DsheapmergeableGraphN {
  let result = ds_heap_mergeable_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_mergeable_graphn_add(a : DsheapmergeableGraphN, b : DsheapmergeableGraphN) -> DsheapmergeableGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_mergeable_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_mergeable_graphn_copy(s : DsheapmergeableGraphN) -> DsheapmergeableGraphN {
  let result = ds_heap_mergeable_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_mergeable_graphn_fill(s : DsheapmergeableGraphN, v : Double) -> DsheapmergeableGraphN {
  let result = ds_heap_mergeable_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_graphn_min(s : DsheapmergeableGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_graphn_max(s : DsheapmergeableGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_graphn_to_string(s : DsheapmergeableGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_node_make(size : Int) -> DsheapmergeableNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_node_len(s : DsheapmergeableNode) -> Int { s.size }

pub fn ds_heap_mergeable_node_get(s : DsheapmergeableNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_node_set(s : DsheapmergeableNode, i : Int, v : Double) -> DsheapmergeableNode {
  let result = ds_heap_mergeable_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_node_sum(s : DsheapmergeableNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_mergeable_node_mean(s : DsheapmergeableNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_mergeable_node_sum(s) / s.size.to_double() }
}

pub fn ds_heap_mergeable_node_scale(s : DsheapmergeableNode, f : Double) -> DsheapmergeableNode {
  let result = ds_heap_mergeable_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_mergeable_node_add(a : DsheapmergeableNode, b : DsheapmergeableNode) -> DsheapmergeableNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_mergeable_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_mergeable_node_copy(s : DsheapmergeableNode) -> DsheapmergeableNode {
  let result = ds_heap_mergeable_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_mergeable_node_fill(s : DsheapmergeableNode, v : Double) -> DsheapmergeableNode {
  let result = ds_heap_mergeable_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_node_min(s : DsheapmergeableNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_node_max(s : DsheapmergeableNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_node_to_string(s : DsheapmergeableNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_edge_make(size : Int) -> DsheapmergeableEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_edge_len(s : DsheapmergeableEdge) -> Int { s.size }

pub fn ds_heap_mergeable_edge_get(s : DsheapmergeableEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_edge_set(s : DsheapmergeableEdge, i : Int, v : Double) -> DsheapmergeableEdge {
  let result = ds_heap_mergeable_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_edge_sum(s : DsheapmergeableEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_mergeable_edge_mean(s : DsheapmergeableEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_mergeable_edge_sum(s) / s.size.to_double() }
}

pub fn ds_heap_mergeable_edge_scale(s : DsheapmergeableEdge, f : Double) -> DsheapmergeableEdge {
  let result = ds_heap_mergeable_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_mergeable_edge_add(a : DsheapmergeableEdge, b : DsheapmergeableEdge) -> DsheapmergeableEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_mergeable_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_mergeable_edge_copy(s : DsheapmergeableEdge) -> DsheapmergeableEdge {
  let result = ds_heap_mergeable_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_mergeable_edge_fill(s : DsheapmergeableEdge, v : Double) -> DsheapmergeableEdge {
  let result = ds_heap_mergeable_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_edge_min(s : DsheapmergeableEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_edge_max(s : DsheapmergeableEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_edge_to_string(s : DsheapmergeableEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeablePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_path_make(size : Int) -> DsheapmergeablePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_path_len(s : DsheapmergeablePath) -> Int { s.size }

pub fn ds_heap_mergeable_path_get(s : DsheapmergeablePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_path_set(s : DsheapmergeablePath, i : Int, v : Double) -> DsheapmergeablePath {
  let result = ds_heap_mergeable_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_path_sum(s : DsheapmergeablePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_mergeable_path_mean(s : DsheapmergeablePath) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_mergeable_path_sum(s) / s.size.to_double() }
}

pub fn ds_heap_mergeable_path_scale(s : DsheapmergeablePath, f : Double) -> DsheapmergeablePath {
  let result = ds_heap_mergeable_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_mergeable_path_add(a : DsheapmergeablePath, b : DsheapmergeablePath) -> DsheapmergeablePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_mergeable_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_mergeable_path_copy(s : DsheapmergeablePath) -> DsheapmergeablePath {
  let result = ds_heap_mergeable_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_mergeable_path_fill(s : DsheapmergeablePath, v : Double) -> DsheapmergeablePath {
  let result = ds_heap_mergeable_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_path_min(s : DsheapmergeablePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_path_max(s : DsheapmergeablePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_path_to_string(s : DsheapmergeablePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_cluster_make(size : Int) -> DsheapmergeableCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_cluster_len(s : DsheapmergeableCluster) -> Int { s.size }

pub fn ds_heap_mergeable_cluster_get(s : DsheapmergeableCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_cluster_set(s : DsheapmergeableCluster, i : Int, v : Double) -> DsheapmergeableCluster {
  let result = ds_heap_mergeable_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_cluster_sum(s : DsheapmergeableCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_mergeable_cluster_mean(s : DsheapmergeableCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_mergeable_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_heap_mergeable_cluster_scale(s : DsheapmergeableCluster, f : Double) -> DsheapmergeableCluster {
  let result = ds_heap_mergeable_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_mergeable_cluster_add(a : DsheapmergeableCluster, b : DsheapmergeableCluster) -> DsheapmergeableCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_mergeable_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_mergeable_cluster_copy(s : DsheapmergeableCluster) -> DsheapmergeableCluster {
  let result = ds_heap_mergeable_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_mergeable_cluster_fill(s : DsheapmergeableCluster, v : Double) -> DsheapmergeableCluster {
  let result = ds_heap_mergeable_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_cluster_min(s : DsheapmergeableCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_cluster_max(s : DsheapmergeableCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_cluster_to_string(s : DsheapmergeableCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_model_make(size : Int) -> DsheapmergeableModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_model_len(s : DsheapmergeableModel) -> Int { s.size }

pub fn ds_heap_mergeable_model_get(s : DsheapmergeableModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_model_set(s : DsheapmergeableModel, i : Int, v : Double) -> DsheapmergeableModel {
  let result = ds_heap_mergeable_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_model_sum(s : DsheapmergeableModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_mergeable_model_mean(s : DsheapmergeableModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_mergeable_model_sum(s) / s.size.to_double() }
}

pub fn ds_heap_mergeable_model_scale(s : DsheapmergeableModel, f : Double) -> DsheapmergeableModel {
  let result = ds_heap_mergeable_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_mergeable_model_add(a : DsheapmergeableModel, b : DsheapmergeableModel) -> DsheapmergeableModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_mergeable_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_mergeable_model_copy(s : DsheapmergeableModel) -> DsheapmergeableModel {
  let result = ds_heap_mergeable_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_mergeable_model_fill(s : DsheapmergeableModel, v : Double) -> DsheapmergeableModel {
  let result = ds_heap_mergeable_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_model_min(s : DsheapmergeableModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_model_max(s : DsheapmergeableModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_model_to_string(s : DsheapmergeableModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_layer_make(size : Int) -> DsheapmergeableLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_layer_len(s : DsheapmergeableLayer) -> Int { s.size }

pub fn ds_heap_mergeable_layer_get(s : DsheapmergeableLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_layer_set(s : DsheapmergeableLayer, i : Int, v : Double) -> DsheapmergeableLayer {
  let result = ds_heap_mergeable_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_layer_sum(s : DsheapmergeableLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_mergeable_layer_mean(s : DsheapmergeableLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_mergeable_layer_sum(s) / s.size.to_double() }
}

pub fn ds_heap_mergeable_layer_scale(s : DsheapmergeableLayer, f : Double) -> DsheapmergeableLayer {
  let result = ds_heap_mergeable_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_mergeable_layer_add(a : DsheapmergeableLayer, b : DsheapmergeableLayer) -> DsheapmergeableLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_mergeable_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_mergeable_layer_copy(s : DsheapmergeableLayer) -> DsheapmergeableLayer {
  let result = ds_heap_mergeable_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_mergeable_layer_fill(s : DsheapmergeableLayer, v : Double) -> DsheapmergeableLayer {
  let result = ds_heap_mergeable_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_layer_min(s : DsheapmergeableLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_layer_max(s : DsheapmergeableLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_layer_to_string(s : DsheapmergeableLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_buffer_make(size : Int) -> DsheapmergeableBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_buffer_len(s : DsheapmergeableBuffer) -> Int { s.size }

pub fn ds_heap_mergeable_buffer_get(s : DsheapmergeableBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_buffer_set(s : DsheapmergeableBuffer, i : Int, v : Double) -> DsheapmergeableBuffer {
  let result = ds_heap_mergeable_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_buffer_sum(s : DsheapmergeableBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_mergeable_buffer_mean(s : DsheapmergeableBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_mergeable_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_heap_mergeable_buffer_scale(s : DsheapmergeableBuffer, f : Double) -> DsheapmergeableBuffer {
  let result = ds_heap_mergeable_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_mergeable_buffer_add(a : DsheapmergeableBuffer, b : DsheapmergeableBuffer) -> DsheapmergeableBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_mergeable_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_mergeable_buffer_copy(s : DsheapmergeableBuffer) -> DsheapmergeableBuffer {
  let result = ds_heap_mergeable_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_mergeable_buffer_fill(s : DsheapmergeableBuffer, v : Double) -> DsheapmergeableBuffer {
  let result = ds_heap_mergeable_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_buffer_min(s : DsheapmergeableBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_buffer_max(s : DsheapmergeableBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_buffer_to_string(s : DsheapmergeableBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_cursor_make(size : Int) -> DsheapmergeableCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_cursor_len(s : DsheapmergeableCursor) -> Int { s.size }

pub fn ds_heap_mergeable_cursor_get(s : DsheapmergeableCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_cursor_set(s : DsheapmergeableCursor, i : Int, v : Double) -> DsheapmergeableCursor {
  let result = ds_heap_mergeable_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_cursor_sum(s : DsheapmergeableCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_mergeable_cursor_mean(s : DsheapmergeableCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_mergeable_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_heap_mergeable_cursor_scale(s : DsheapmergeableCursor, f : Double) -> DsheapmergeableCursor {
  let result = ds_heap_mergeable_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_mergeable_cursor_add(a : DsheapmergeableCursor, b : DsheapmergeableCursor) -> DsheapmergeableCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_mergeable_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_mergeable_cursor_copy(s : DsheapmergeableCursor) -> DsheapmergeableCursor {
  let result = ds_heap_mergeable_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_mergeable_cursor_fill(s : DsheapmergeableCursor, v : Double) -> DsheapmergeableCursor {
  let result = ds_heap_mergeable_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_cursor_min(s : DsheapmergeableCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_cursor_max(s : DsheapmergeableCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_cursor_to_string(s : DsheapmergeableCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_view_make(size : Int) -> DsheapmergeableView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_view_len(s : DsheapmergeableView) -> Int { s.size }

pub fn ds_heap_mergeable_view_get(s : DsheapmergeableView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_view_set(s : DsheapmergeableView, i : Int, v : Double) -> DsheapmergeableView {
  let result = ds_heap_mergeable_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_view_sum(s : DsheapmergeableView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_mergeable_view_mean(s : DsheapmergeableView) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_mergeable_view_sum(s) / s.size.to_double() }
}

pub fn ds_heap_mergeable_view_scale(s : DsheapmergeableView, f : Double) -> DsheapmergeableView {
  let result = ds_heap_mergeable_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_mergeable_view_add(a : DsheapmergeableView, b : DsheapmergeableView) -> DsheapmergeableView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_mergeable_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_mergeable_view_copy(s : DsheapmergeableView) -> DsheapmergeableView {
  let result = ds_heap_mergeable_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_mergeable_view_fill(s : DsheapmergeableView, v : Double) -> DsheapmergeableView {
  let result = ds_heap_mergeable_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_view_min(s : DsheapmergeableView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_view_max(s : DsheapmergeableView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_view_to_string(s : DsheapmergeableView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_range_make(size : Int) -> DsheapmergeableRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_range_len(s : DsheapmergeableRange) -> Int { s.size }

pub fn ds_heap_mergeable_range_get(s : DsheapmergeableRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_range_set(s : DsheapmergeableRange, i : Int, v : Double) -> DsheapmergeableRange {
  let result = ds_heap_mergeable_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_range_sum(s : DsheapmergeableRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_mergeable_range_mean(s : DsheapmergeableRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_mergeable_range_sum(s) / s.size.to_double() }
}

pub fn ds_heap_mergeable_range_scale(s : DsheapmergeableRange, f : Double) -> DsheapmergeableRange {
  let result = ds_heap_mergeable_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_mergeable_range_add(a : DsheapmergeableRange, b : DsheapmergeableRange) -> DsheapmergeableRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_mergeable_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_mergeable_range_copy(s : DsheapmergeableRange) -> DsheapmergeableRange {
  let result = ds_heap_mergeable_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_mergeable_range_fill(s : DsheapmergeableRange, v : Double) -> DsheapmergeableRange {
  let result = ds_heap_mergeable_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_range_min(s : DsheapmergeableRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_range_max(s : DsheapmergeableRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_range_to_string(s : DsheapmergeableRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_slice_make(size : Int) -> DsheapmergeableSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_slice_len(s : DsheapmergeableSlice) -> Int { s.size }

pub fn ds_heap_mergeable_slice_get(s : DsheapmergeableSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_slice_set(s : DsheapmergeableSlice, i : Int, v : Double) -> DsheapmergeableSlice {
  let result = ds_heap_mergeable_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_slice_sum(s : DsheapmergeableSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_mergeable_slice_mean(s : DsheapmergeableSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_mergeable_slice_sum(s) / s.size.to_double() }
}

pub fn ds_heap_mergeable_slice_scale(s : DsheapmergeableSlice, f : Double) -> DsheapmergeableSlice {
  let result = ds_heap_mergeable_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_mergeable_slice_add(a : DsheapmergeableSlice, b : DsheapmergeableSlice) -> DsheapmergeableSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_mergeable_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_mergeable_slice_copy(s : DsheapmergeableSlice) -> DsheapmergeableSlice {
  let result = ds_heap_mergeable_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_mergeable_slice_fill(s : DsheapmergeableSlice, v : Double) -> DsheapmergeableSlice {
  let result = ds_heap_mergeable_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_mergeable_slice_min(s : DsheapmergeableSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_slice_max(s : DsheapmergeableSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_mergeable_slice_to_string(s : DsheapmergeableSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

