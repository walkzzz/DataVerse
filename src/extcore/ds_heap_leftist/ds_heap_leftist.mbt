///===
/// extcore/ds_heap_leftist

pub(all) struct DsheapleftistPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_leftist_make_point(x : Double, y : Double) -> DsheapleftistPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_leftist_make_point3(x : Double, y : Double, z : Double) -> DsheapleftistPoint {
  { x, y, z, label: 0 }
}

pub fn ds_heap_leftist_point_x(pt : DsheapleftistPoint) -> Double { pt.x }

pub fn ds_heap_leftist_point_y(pt : DsheapleftistPoint) -> Double { pt.y }

pub fn ds_heap_leftist_point_z(pt : DsheapleftistPoint) -> Double { pt.z }

pub fn ds_heap_leftist_point_label(pt : DsheapleftistPoint) -> Int { pt.label }

pub fn ds_heap_leftist_point_dist(a : DsheapleftistPoint, b : DsheapleftistPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_heap_leftist_point_add(a : DsheapleftistPoint, b : DsheapleftistPoint) -> DsheapleftistPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_heap_leftist_point_sub(a : DsheapleftistPoint, b : DsheapleftistPoint) -> DsheapleftistPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_heap_leftist_point_scale(pt : DsheapleftistPoint, s : Double) -> DsheapleftistPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_heap_leftist_point_dot(a : DsheapleftistPoint, b : DsheapleftistPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_heap_leftist_point_cross(a : DsheapleftistPoint, b : DsheapleftistPoint) -> DsheapleftistPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_heap_leftist_point_norm(pt : DsheapleftistPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_heap_leftist_point_normalize(pt : DsheapleftistPoint) -> DsheapleftistPoint {
  let n = ds_heap_leftist_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_heap_leftist_point_scale(pt, 1.0 / n) }
}

pub fn ds_heap_leftist_point_negate(pt : DsheapleftistPoint) -> DsheapleftistPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_heap_leftist_point_mid(a : DsheapleftistPoint, b : DsheapleftistPoint) -> DsheapleftistPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_heap_leftist_point_lerp(a : DsheapleftistPoint, b : DsheapleftistPoint, t : Double) -> DsheapleftistPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_heap_leftist_point_to_string(pt : DsheapleftistPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsheapleftistSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_leftist_make_series(vals : Array[Double], name : String) -> DsheapleftistSeries {
  { vals, name, meta: 0 }
}

pub fn ds_heap_leftist_series_len(s : DsheapleftistSeries) -> Int { s.vals.length() }

pub fn ds_heap_leftist_series_sum(s : DsheapleftistSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_heap_leftist_series_mean(s : DsheapleftistSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_heap_leftist_series_min(s : DsheapleftistSeries) -> Double { @_common.min(s.vals) }

pub fn ds_heap_leftist_series_max(s : DsheapleftistSeries) -> Double { @_common.max(s.vals) }

pub fn ds_heap_leftist_series_range(s : DsheapleftistSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_heap_leftist_series_var(s : DsheapleftistSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_heap_leftist_series_std(s : DsheapleftistSeries) -> Double { @_common.std(s.vals) }

pub fn ds_heap_leftist_series_median(s : DsheapleftistSeries) -> Double { @_common.median(s.vals) }

pub fn ds_heap_leftist_series_scale(s : DsheapleftistSeries, f : Double) -> DsheapleftistSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_heap_leftist_series_add(a : DsheapleftistSeries, b : DsheapleftistSeries) -> DsheapleftistSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_heap_leftist_series_sub(a : DsheapleftistSeries, b : DsheapleftistSeries) -> DsheapleftistSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_heap_leftist_series_normalize(s : DsheapleftistSeries) -> DsheapleftistSeries {
  let mn = ds_heap_leftist_series_min(s)
  let mx = ds_heap_leftist_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_heap_leftist_series_cumsum(s : DsheapleftistSeries) -> DsheapleftistSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_heap_leftist_series_to_string(s : DsheapleftistSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapleftistMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_leftist_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapleftistMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_leftist_matrix_identity(n : Int) -> DsheapleftistMatrix {
  let m = ds_heap_leftist_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_heap_leftist_matrix_get(m : DsheapleftistMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_heap_leftist_matrix_transpose(m : DsheapleftistMatrix) -> DsheapleftistMatrix {
  let result = ds_heap_leftist_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_heap_leftist_matrix_add(a : DsheapleftistMatrix, b : DsheapleftistMatrix) -> DsheapleftistMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_heap_leftist_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_heap_leftist_matrix_scale(m : DsheapleftistMatrix, s : Double) -> DsheapleftistMatrix {
  let result = ds_heap_leftist_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_heap_leftist_matrix_multiply(a : DsheapleftistMatrix, b : DsheapleftistMatrix) -> DsheapleftistMatrix {
  if a.cols != b.rows { return ds_heap_leftist_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_heap_leftist_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_heap_leftist_matrix_trace(m : DsheapleftistMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_heap_leftist_matrix_det(m : DsheapleftistMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_heap_leftist_matrix_norm(m : DsheapleftistMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_heap_leftist_matrix_to_string(m : DsheapleftistMatrix) -> String {
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

pub(all) struct DsheapleftistVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_leftist_make_vector(comps : Array[Double]) -> DsheapleftistVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_leftist_vector_zero(dim : Int) -> DsheapleftistVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_heap_leftist_vector_add(a : DsheapleftistVector, b : DsheapleftistVector) -> DsheapleftistVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_heap_leftist_vector_sub(a : DsheapleftistVector, b : DsheapleftistVector) -> DsheapleftistVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_heap_leftist_vector_scale(v : DsheapleftistVector, s : Double) -> DsheapleftistVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_heap_leftist_vector_dot(a : DsheapleftistVector, b : DsheapleftistVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_heap_leftist_vector_norm(v : DsheapleftistVector) -> Double { @_common.sqrt(ds_heap_leftist_vector_dot(v, v)) }

pub fn ds_heap_leftist_vector_normalize(v : DsheapleftistVector) -> DsheapleftistVector {
  let n = ds_heap_leftist_vector_norm(v)
  if n < 0.0000001 { v } else { ds_heap_leftist_vector_scale(v, 1.0 / n) }
}

pub fn ds_heap_leftist_vector_dist(a : DsheapleftistVector, b : DsheapleftistVector) -> Double {
  ds_heap_leftist_vector_norm(ds_heap_leftist_vector_sub(a, b))
}

pub fn ds_heap_leftist_vector_to_string(v : DsheapleftistVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_leftist_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_heap_leftist_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_heap_leftist_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_heap_leftist_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_heap_leftist_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_heap_leftist_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_heap_leftist_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_heap_leftist_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_heap_leftist_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_heap_leftist_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_heap_leftist_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_heap_leftist_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_heap_leftist_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_heap_leftist_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_heap_leftist_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_heap_leftist_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_heap_leftist_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_heap_leftist_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_heap_leftist_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_heap_leftist_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_heap_leftist_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_heap_leftist_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_heap_leftist_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_heap_leftist_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_heap_leftist_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_heap_leftist_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_heap_leftist_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_heap_leftist_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_heap_leftist_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsheapleftistFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_frame_make(size : Int) -> DsheapleftistFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_frame_len(s : DsheapleftistFrame) -> Int { s.size }

pub fn ds_heap_leftist_frame_get(s : DsheapleftistFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_frame_set(s : DsheapleftistFrame, i : Int, v : Double) -> DsheapleftistFrame {
  let result = ds_heap_leftist_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_frame_sum(s : DsheapleftistFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_leftist_frame_mean(s : DsheapleftistFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_leftist_frame_sum(s) / s.size.to_double() }
}

pub fn ds_heap_leftist_frame_scale(s : DsheapleftistFrame, f : Double) -> DsheapleftistFrame {
  let result = ds_heap_leftist_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_leftist_frame_add(a : DsheapleftistFrame, b : DsheapleftistFrame) -> DsheapleftistFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_leftist_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_leftist_frame_copy(s : DsheapleftistFrame) -> DsheapleftistFrame {
  let result = ds_heap_leftist_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_leftist_frame_fill(s : DsheapleftistFrame, v : Double) -> DsheapleftistFrame {
  let result = ds_heap_leftist_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_frame_min(s : DsheapleftistFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_frame_max(s : DsheapleftistFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_frame_to_string(s : DsheapleftistFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_table_make(size : Int) -> DsheapleftistTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_table_len(s : DsheapleftistTable) -> Int { s.size }

pub fn ds_heap_leftist_table_get(s : DsheapleftistTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_table_set(s : DsheapleftistTable, i : Int, v : Double) -> DsheapleftistTable {
  let result = ds_heap_leftist_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_table_sum(s : DsheapleftistTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_leftist_table_mean(s : DsheapleftistTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_leftist_table_sum(s) / s.size.to_double() }
}

pub fn ds_heap_leftist_table_scale(s : DsheapleftistTable, f : Double) -> DsheapleftistTable {
  let result = ds_heap_leftist_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_leftist_table_add(a : DsheapleftistTable, b : DsheapleftistTable) -> DsheapleftistTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_leftist_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_leftist_table_copy(s : DsheapleftistTable) -> DsheapleftistTable {
  let result = ds_heap_leftist_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_leftist_table_fill(s : DsheapleftistTable, v : Double) -> DsheapleftistTable {
  let result = ds_heap_leftist_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_table_min(s : DsheapleftistTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_table_max(s : DsheapleftistTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_table_to_string(s : DsheapleftistTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_graphn_make(size : Int) -> DsheapleftistGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_graphn_len(s : DsheapleftistGraphN) -> Int { s.size }

pub fn ds_heap_leftist_graphn_get(s : DsheapleftistGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_graphn_set(s : DsheapleftistGraphN, i : Int, v : Double) -> DsheapleftistGraphN {
  let result = ds_heap_leftist_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_graphn_sum(s : DsheapleftistGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_leftist_graphn_mean(s : DsheapleftistGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_leftist_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_heap_leftist_graphn_scale(s : DsheapleftistGraphN, f : Double) -> DsheapleftistGraphN {
  let result = ds_heap_leftist_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_leftist_graphn_add(a : DsheapleftistGraphN, b : DsheapleftistGraphN) -> DsheapleftistGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_leftist_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_leftist_graphn_copy(s : DsheapleftistGraphN) -> DsheapleftistGraphN {
  let result = ds_heap_leftist_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_leftist_graphn_fill(s : DsheapleftistGraphN, v : Double) -> DsheapleftistGraphN {
  let result = ds_heap_leftist_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_graphn_min(s : DsheapleftistGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_graphn_max(s : DsheapleftistGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_graphn_to_string(s : DsheapleftistGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_node_make(size : Int) -> DsheapleftistNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_node_len(s : DsheapleftistNode) -> Int { s.size }

pub fn ds_heap_leftist_node_get(s : DsheapleftistNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_node_set(s : DsheapleftistNode, i : Int, v : Double) -> DsheapleftistNode {
  let result = ds_heap_leftist_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_node_sum(s : DsheapleftistNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_leftist_node_mean(s : DsheapleftistNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_leftist_node_sum(s) / s.size.to_double() }
}

pub fn ds_heap_leftist_node_scale(s : DsheapleftistNode, f : Double) -> DsheapleftistNode {
  let result = ds_heap_leftist_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_leftist_node_add(a : DsheapleftistNode, b : DsheapleftistNode) -> DsheapleftistNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_leftist_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_leftist_node_copy(s : DsheapleftistNode) -> DsheapleftistNode {
  let result = ds_heap_leftist_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_leftist_node_fill(s : DsheapleftistNode, v : Double) -> DsheapleftistNode {
  let result = ds_heap_leftist_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_node_min(s : DsheapleftistNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_node_max(s : DsheapleftistNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_node_to_string(s : DsheapleftistNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_edge_make(size : Int) -> DsheapleftistEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_edge_len(s : DsheapleftistEdge) -> Int { s.size }

pub fn ds_heap_leftist_edge_get(s : DsheapleftistEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_edge_set(s : DsheapleftistEdge, i : Int, v : Double) -> DsheapleftistEdge {
  let result = ds_heap_leftist_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_edge_sum(s : DsheapleftistEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_leftist_edge_mean(s : DsheapleftistEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_leftist_edge_sum(s) / s.size.to_double() }
}

pub fn ds_heap_leftist_edge_scale(s : DsheapleftistEdge, f : Double) -> DsheapleftistEdge {
  let result = ds_heap_leftist_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_leftist_edge_add(a : DsheapleftistEdge, b : DsheapleftistEdge) -> DsheapleftistEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_leftist_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_leftist_edge_copy(s : DsheapleftistEdge) -> DsheapleftistEdge {
  let result = ds_heap_leftist_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_leftist_edge_fill(s : DsheapleftistEdge, v : Double) -> DsheapleftistEdge {
  let result = ds_heap_leftist_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_edge_min(s : DsheapleftistEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_edge_max(s : DsheapleftistEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_edge_to_string(s : DsheapleftistEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_path_make(size : Int) -> DsheapleftistPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_path_len(s : DsheapleftistPath) -> Int { s.size }

pub fn ds_heap_leftist_path_get(s : DsheapleftistPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_path_set(s : DsheapleftistPath, i : Int, v : Double) -> DsheapleftistPath {
  let result = ds_heap_leftist_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_path_sum(s : DsheapleftistPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_leftist_path_mean(s : DsheapleftistPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_leftist_path_sum(s) / s.size.to_double() }
}

pub fn ds_heap_leftist_path_scale(s : DsheapleftistPath, f : Double) -> DsheapleftistPath {
  let result = ds_heap_leftist_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_leftist_path_add(a : DsheapleftistPath, b : DsheapleftistPath) -> DsheapleftistPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_leftist_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_leftist_path_copy(s : DsheapleftistPath) -> DsheapleftistPath {
  let result = ds_heap_leftist_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_leftist_path_fill(s : DsheapleftistPath, v : Double) -> DsheapleftistPath {
  let result = ds_heap_leftist_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_path_min(s : DsheapleftistPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_path_max(s : DsheapleftistPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_path_to_string(s : DsheapleftistPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_cluster_make(size : Int) -> DsheapleftistCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_cluster_len(s : DsheapleftistCluster) -> Int { s.size }

pub fn ds_heap_leftist_cluster_get(s : DsheapleftistCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_cluster_set(s : DsheapleftistCluster, i : Int, v : Double) -> DsheapleftistCluster {
  let result = ds_heap_leftist_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_cluster_sum(s : DsheapleftistCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_leftist_cluster_mean(s : DsheapleftistCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_leftist_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_heap_leftist_cluster_scale(s : DsheapleftistCluster, f : Double) -> DsheapleftistCluster {
  let result = ds_heap_leftist_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_leftist_cluster_add(a : DsheapleftistCluster, b : DsheapleftistCluster) -> DsheapleftistCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_leftist_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_leftist_cluster_copy(s : DsheapleftistCluster) -> DsheapleftistCluster {
  let result = ds_heap_leftist_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_leftist_cluster_fill(s : DsheapleftistCluster, v : Double) -> DsheapleftistCluster {
  let result = ds_heap_leftist_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_cluster_min(s : DsheapleftistCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_cluster_max(s : DsheapleftistCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_cluster_to_string(s : DsheapleftistCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_model_make(size : Int) -> DsheapleftistModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_model_len(s : DsheapleftistModel) -> Int { s.size }

pub fn ds_heap_leftist_model_get(s : DsheapleftistModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_model_set(s : DsheapleftistModel, i : Int, v : Double) -> DsheapleftistModel {
  let result = ds_heap_leftist_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_model_sum(s : DsheapleftistModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_leftist_model_mean(s : DsheapleftistModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_leftist_model_sum(s) / s.size.to_double() }
}

pub fn ds_heap_leftist_model_scale(s : DsheapleftistModel, f : Double) -> DsheapleftistModel {
  let result = ds_heap_leftist_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_leftist_model_add(a : DsheapleftistModel, b : DsheapleftistModel) -> DsheapleftistModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_leftist_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_leftist_model_copy(s : DsheapleftistModel) -> DsheapleftistModel {
  let result = ds_heap_leftist_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_leftist_model_fill(s : DsheapleftistModel, v : Double) -> DsheapleftistModel {
  let result = ds_heap_leftist_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_model_min(s : DsheapleftistModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_model_max(s : DsheapleftistModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_model_to_string(s : DsheapleftistModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_layer_make(size : Int) -> DsheapleftistLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_layer_len(s : DsheapleftistLayer) -> Int { s.size }

pub fn ds_heap_leftist_layer_get(s : DsheapleftistLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_layer_set(s : DsheapleftistLayer, i : Int, v : Double) -> DsheapleftistLayer {
  let result = ds_heap_leftist_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_layer_sum(s : DsheapleftistLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_leftist_layer_mean(s : DsheapleftistLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_leftist_layer_sum(s) / s.size.to_double() }
}

pub fn ds_heap_leftist_layer_scale(s : DsheapleftistLayer, f : Double) -> DsheapleftistLayer {
  let result = ds_heap_leftist_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_leftist_layer_add(a : DsheapleftistLayer, b : DsheapleftistLayer) -> DsheapleftistLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_leftist_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_leftist_layer_copy(s : DsheapleftistLayer) -> DsheapleftistLayer {
  let result = ds_heap_leftist_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_leftist_layer_fill(s : DsheapleftistLayer, v : Double) -> DsheapleftistLayer {
  let result = ds_heap_leftist_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_layer_min(s : DsheapleftistLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_layer_max(s : DsheapleftistLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_layer_to_string(s : DsheapleftistLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_buffer_make(size : Int) -> DsheapleftistBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_buffer_len(s : DsheapleftistBuffer) -> Int { s.size }

pub fn ds_heap_leftist_buffer_get(s : DsheapleftistBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_buffer_set(s : DsheapleftistBuffer, i : Int, v : Double) -> DsheapleftistBuffer {
  let result = ds_heap_leftist_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_buffer_sum(s : DsheapleftistBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_leftist_buffer_mean(s : DsheapleftistBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_leftist_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_heap_leftist_buffer_scale(s : DsheapleftistBuffer, f : Double) -> DsheapleftistBuffer {
  let result = ds_heap_leftist_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_leftist_buffer_add(a : DsheapleftistBuffer, b : DsheapleftistBuffer) -> DsheapleftistBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_leftist_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_leftist_buffer_copy(s : DsheapleftistBuffer) -> DsheapleftistBuffer {
  let result = ds_heap_leftist_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_leftist_buffer_fill(s : DsheapleftistBuffer, v : Double) -> DsheapleftistBuffer {
  let result = ds_heap_leftist_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_buffer_min(s : DsheapleftistBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_buffer_max(s : DsheapleftistBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_buffer_to_string(s : DsheapleftistBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_cursor_make(size : Int) -> DsheapleftistCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_cursor_len(s : DsheapleftistCursor) -> Int { s.size }

pub fn ds_heap_leftist_cursor_get(s : DsheapleftistCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_cursor_set(s : DsheapleftistCursor, i : Int, v : Double) -> DsheapleftistCursor {
  let result = ds_heap_leftist_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_cursor_sum(s : DsheapleftistCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_leftist_cursor_mean(s : DsheapleftistCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_leftist_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_heap_leftist_cursor_scale(s : DsheapleftistCursor, f : Double) -> DsheapleftistCursor {
  let result = ds_heap_leftist_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_leftist_cursor_add(a : DsheapleftistCursor, b : DsheapleftistCursor) -> DsheapleftistCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_leftist_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_leftist_cursor_copy(s : DsheapleftistCursor) -> DsheapleftistCursor {
  let result = ds_heap_leftist_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_leftist_cursor_fill(s : DsheapleftistCursor, v : Double) -> DsheapleftistCursor {
  let result = ds_heap_leftist_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_cursor_min(s : DsheapleftistCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_cursor_max(s : DsheapleftistCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_cursor_to_string(s : DsheapleftistCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_view_make(size : Int) -> DsheapleftistView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_view_len(s : DsheapleftistView) -> Int { s.size }

pub fn ds_heap_leftist_view_get(s : DsheapleftistView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_view_set(s : DsheapleftistView, i : Int, v : Double) -> DsheapleftistView {
  let result = ds_heap_leftist_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_view_sum(s : DsheapleftistView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_leftist_view_mean(s : DsheapleftistView) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_leftist_view_sum(s) / s.size.to_double() }
}

pub fn ds_heap_leftist_view_scale(s : DsheapleftistView, f : Double) -> DsheapleftistView {
  let result = ds_heap_leftist_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_leftist_view_add(a : DsheapleftistView, b : DsheapleftistView) -> DsheapleftistView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_leftist_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_leftist_view_copy(s : DsheapleftistView) -> DsheapleftistView {
  let result = ds_heap_leftist_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_leftist_view_fill(s : DsheapleftistView, v : Double) -> DsheapleftistView {
  let result = ds_heap_leftist_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_view_min(s : DsheapleftistView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_view_max(s : DsheapleftistView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_view_to_string(s : DsheapleftistView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_range_make(size : Int) -> DsheapleftistRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_range_len(s : DsheapleftistRange) -> Int { s.size }

pub fn ds_heap_leftist_range_get(s : DsheapleftistRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_range_set(s : DsheapleftistRange, i : Int, v : Double) -> DsheapleftistRange {
  let result = ds_heap_leftist_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_range_sum(s : DsheapleftistRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_leftist_range_mean(s : DsheapleftistRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_leftist_range_sum(s) / s.size.to_double() }
}

pub fn ds_heap_leftist_range_scale(s : DsheapleftistRange, f : Double) -> DsheapleftistRange {
  let result = ds_heap_leftist_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_leftist_range_add(a : DsheapleftistRange, b : DsheapleftistRange) -> DsheapleftistRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_leftist_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_leftist_range_copy(s : DsheapleftistRange) -> DsheapleftistRange {
  let result = ds_heap_leftist_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_leftist_range_fill(s : DsheapleftistRange, v : Double) -> DsheapleftistRange {
  let result = ds_heap_leftist_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_range_min(s : DsheapleftistRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_range_max(s : DsheapleftistRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_range_to_string(s : DsheapleftistRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_slice_make(size : Int) -> DsheapleftistSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_slice_len(s : DsheapleftistSlice) -> Int { s.size }

pub fn ds_heap_leftist_slice_get(s : DsheapleftistSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_slice_set(s : DsheapleftistSlice, i : Int, v : Double) -> DsheapleftistSlice {
  let result = ds_heap_leftist_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_slice_sum(s : DsheapleftistSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_leftist_slice_mean(s : DsheapleftistSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_leftist_slice_sum(s) / s.size.to_double() }
}

pub fn ds_heap_leftist_slice_scale(s : DsheapleftistSlice, f : Double) -> DsheapleftistSlice {
  let result = ds_heap_leftist_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_leftist_slice_add(a : DsheapleftistSlice, b : DsheapleftistSlice) -> DsheapleftistSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_leftist_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_leftist_slice_copy(s : DsheapleftistSlice) -> DsheapleftistSlice {
  let result = ds_heap_leftist_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_leftist_slice_fill(s : DsheapleftistSlice, v : Double) -> DsheapleftistSlice {
  let result = ds_heap_leftist_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_leftist_slice_min(s : DsheapleftistSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_slice_max(s : DsheapleftistSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_leftist_slice_to_string(s : DsheapleftistSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

