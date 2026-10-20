///===
/// extcore/ds_heap_interval

pub(all) struct DsheapintervalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_interval_make_point(x : Double, y : Double) -> DsheapintervalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_interval_make_point3(x : Double, y : Double, z : Double) -> DsheapintervalPoint {
  { x, y, z, label: 0 }
}

pub fn ds_heap_interval_point_x(pt : DsheapintervalPoint) -> Double { pt.x }

pub fn ds_heap_interval_point_y(pt : DsheapintervalPoint) -> Double { pt.y }

pub fn ds_heap_interval_point_z(pt : DsheapintervalPoint) -> Double { pt.z }

pub fn ds_heap_interval_point_label(pt : DsheapintervalPoint) -> Int { pt.label }

pub fn ds_heap_interval_point_dist(a : DsheapintervalPoint, b : DsheapintervalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_heap_interval_point_add(a : DsheapintervalPoint, b : DsheapintervalPoint) -> DsheapintervalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_heap_interval_point_sub(a : DsheapintervalPoint, b : DsheapintervalPoint) -> DsheapintervalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_heap_interval_point_scale(pt : DsheapintervalPoint, s : Double) -> DsheapintervalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_heap_interval_point_dot(a : DsheapintervalPoint, b : DsheapintervalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_heap_interval_point_cross(a : DsheapintervalPoint, b : DsheapintervalPoint) -> DsheapintervalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_heap_interval_point_norm(pt : DsheapintervalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_heap_interval_point_normalize(pt : DsheapintervalPoint) -> DsheapintervalPoint {
  let n = ds_heap_interval_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_heap_interval_point_scale(pt, 1.0 / n) }
}

pub fn ds_heap_interval_point_negate(pt : DsheapintervalPoint) -> DsheapintervalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_heap_interval_point_mid(a : DsheapintervalPoint, b : DsheapintervalPoint) -> DsheapintervalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_heap_interval_point_lerp(a : DsheapintervalPoint, b : DsheapintervalPoint, t : Double) -> DsheapintervalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_heap_interval_point_to_string(pt : DsheapintervalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsheapintervalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_interval_make_series(vals : Array[Double], name : String) -> DsheapintervalSeries {
  { vals, name, meta: 0 }
}

pub fn ds_heap_interval_series_len(s : DsheapintervalSeries) -> Int { s.vals.length() }

pub fn ds_heap_interval_series_sum(s : DsheapintervalSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_heap_interval_series_mean(s : DsheapintervalSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_heap_interval_series_min(s : DsheapintervalSeries) -> Double { @_common.min(s.vals) }

pub fn ds_heap_interval_series_max(s : DsheapintervalSeries) -> Double { @_common.max(s.vals) }

pub fn ds_heap_interval_series_range(s : DsheapintervalSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_heap_interval_series_var(s : DsheapintervalSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_heap_interval_series_std(s : DsheapintervalSeries) -> Double { @_common.std(s.vals) }

pub fn ds_heap_interval_series_median(s : DsheapintervalSeries) -> Double { @_common.median(s.vals) }

pub fn ds_heap_interval_series_scale(s : DsheapintervalSeries, f : Double) -> DsheapintervalSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_heap_interval_series_add(a : DsheapintervalSeries, b : DsheapintervalSeries) -> DsheapintervalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_heap_interval_series_sub(a : DsheapintervalSeries, b : DsheapintervalSeries) -> DsheapintervalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_heap_interval_series_normalize(s : DsheapintervalSeries) -> DsheapintervalSeries {
  let mn = ds_heap_interval_series_min(s)
  let mx = ds_heap_interval_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_heap_interval_series_cumsum(s : DsheapintervalSeries) -> DsheapintervalSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_heap_interval_series_to_string(s : DsheapintervalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapintervalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_interval_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapintervalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_interval_matrix_identity(n : Int) -> DsheapintervalMatrix {
  let m = ds_heap_interval_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_heap_interval_matrix_get(m : DsheapintervalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_heap_interval_matrix_transpose(m : DsheapintervalMatrix) -> DsheapintervalMatrix {
  let result = ds_heap_interval_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_heap_interval_matrix_add(a : DsheapintervalMatrix, b : DsheapintervalMatrix) -> DsheapintervalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_heap_interval_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_heap_interval_matrix_scale(m : DsheapintervalMatrix, s : Double) -> DsheapintervalMatrix {
  let result = ds_heap_interval_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_heap_interval_matrix_multiply(a : DsheapintervalMatrix, b : DsheapintervalMatrix) -> DsheapintervalMatrix {
  if a.cols != b.rows { return ds_heap_interval_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_heap_interval_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_heap_interval_matrix_trace(m : DsheapintervalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_heap_interval_matrix_det(m : DsheapintervalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_heap_interval_matrix_norm(m : DsheapintervalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_heap_interval_matrix_to_string(m : DsheapintervalMatrix) -> String {
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

pub(all) struct DsheapintervalVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_interval_make_vector(comps : Array[Double]) -> DsheapintervalVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_interval_vector_zero(dim : Int) -> DsheapintervalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_heap_interval_vector_add(a : DsheapintervalVector, b : DsheapintervalVector) -> DsheapintervalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_heap_interval_vector_sub(a : DsheapintervalVector, b : DsheapintervalVector) -> DsheapintervalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_heap_interval_vector_scale(v : DsheapintervalVector, s : Double) -> DsheapintervalVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_heap_interval_vector_dot(a : DsheapintervalVector, b : DsheapintervalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_heap_interval_vector_norm(v : DsheapintervalVector) -> Double { @_common.sqrt(ds_heap_interval_vector_dot(v, v)) }

pub fn ds_heap_interval_vector_normalize(v : DsheapintervalVector) -> DsheapintervalVector {
  let n = ds_heap_interval_vector_norm(v)
  if n < 0.0000001 { v } else { ds_heap_interval_vector_scale(v, 1.0 / n) }
}

pub fn ds_heap_interval_vector_dist(a : DsheapintervalVector, b : DsheapintervalVector) -> Double {
  ds_heap_interval_vector_norm(ds_heap_interval_vector_sub(a, b))
}

pub fn ds_heap_interval_vector_to_string(v : DsheapintervalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_interval_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_heap_interval_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_heap_interval_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_heap_interval_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_heap_interval_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_heap_interval_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_heap_interval_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_heap_interval_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_heap_interval_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_heap_interval_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_heap_interval_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_heap_interval_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_heap_interval_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_heap_interval_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_heap_interval_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_heap_interval_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_heap_interval_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_heap_interval_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_heap_interval_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_heap_interval_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_heap_interval_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_heap_interval_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_heap_interval_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_heap_interval_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_heap_interval_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_heap_interval_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_heap_interval_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_heap_interval_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_heap_interval_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsheapintervalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_frame_make(size : Int) -> DsheapintervalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_frame_len(s : DsheapintervalFrame) -> Int { s.size }

pub fn ds_heap_interval_frame_get(s : DsheapintervalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_frame_set(s : DsheapintervalFrame, i : Int, v : Double) -> DsheapintervalFrame {
  let result = ds_heap_interval_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_frame_sum(s : DsheapintervalFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_interval_frame_mean(s : DsheapintervalFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_interval_frame_sum(s) / s.size.to_double() }
}

pub fn ds_heap_interval_frame_scale(s : DsheapintervalFrame, f : Double) -> DsheapintervalFrame {
  let result = ds_heap_interval_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_interval_frame_add(a : DsheapintervalFrame, b : DsheapintervalFrame) -> DsheapintervalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_interval_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_interval_frame_copy(s : DsheapintervalFrame) -> DsheapintervalFrame {
  let result = ds_heap_interval_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_interval_frame_fill(s : DsheapintervalFrame, v : Double) -> DsheapintervalFrame {
  let result = ds_heap_interval_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_frame_min(s : DsheapintervalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_frame_max(s : DsheapintervalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_frame_to_string(s : DsheapintervalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_table_make(size : Int) -> DsheapintervalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_table_len(s : DsheapintervalTable) -> Int { s.size }

pub fn ds_heap_interval_table_get(s : DsheapintervalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_table_set(s : DsheapintervalTable, i : Int, v : Double) -> DsheapintervalTable {
  let result = ds_heap_interval_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_table_sum(s : DsheapintervalTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_interval_table_mean(s : DsheapintervalTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_interval_table_sum(s) / s.size.to_double() }
}

pub fn ds_heap_interval_table_scale(s : DsheapintervalTable, f : Double) -> DsheapintervalTable {
  let result = ds_heap_interval_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_interval_table_add(a : DsheapintervalTable, b : DsheapintervalTable) -> DsheapintervalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_interval_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_interval_table_copy(s : DsheapintervalTable) -> DsheapintervalTable {
  let result = ds_heap_interval_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_interval_table_fill(s : DsheapintervalTable, v : Double) -> DsheapintervalTable {
  let result = ds_heap_interval_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_table_min(s : DsheapintervalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_table_max(s : DsheapintervalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_table_to_string(s : DsheapintervalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_graphn_make(size : Int) -> DsheapintervalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_graphn_len(s : DsheapintervalGraphN) -> Int { s.size }

pub fn ds_heap_interval_graphn_get(s : DsheapintervalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_graphn_set(s : DsheapintervalGraphN, i : Int, v : Double) -> DsheapintervalGraphN {
  let result = ds_heap_interval_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_graphn_sum(s : DsheapintervalGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_interval_graphn_mean(s : DsheapintervalGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_interval_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_heap_interval_graphn_scale(s : DsheapintervalGraphN, f : Double) -> DsheapintervalGraphN {
  let result = ds_heap_interval_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_interval_graphn_add(a : DsheapintervalGraphN, b : DsheapintervalGraphN) -> DsheapintervalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_interval_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_interval_graphn_copy(s : DsheapintervalGraphN) -> DsheapintervalGraphN {
  let result = ds_heap_interval_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_interval_graphn_fill(s : DsheapintervalGraphN, v : Double) -> DsheapintervalGraphN {
  let result = ds_heap_interval_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_graphn_min(s : DsheapintervalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_graphn_max(s : DsheapintervalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_graphn_to_string(s : DsheapintervalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_node_make(size : Int) -> DsheapintervalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_node_len(s : DsheapintervalNode) -> Int { s.size }

pub fn ds_heap_interval_node_get(s : DsheapintervalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_node_set(s : DsheapintervalNode, i : Int, v : Double) -> DsheapintervalNode {
  let result = ds_heap_interval_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_node_sum(s : DsheapintervalNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_interval_node_mean(s : DsheapintervalNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_interval_node_sum(s) / s.size.to_double() }
}

pub fn ds_heap_interval_node_scale(s : DsheapintervalNode, f : Double) -> DsheapintervalNode {
  let result = ds_heap_interval_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_interval_node_add(a : DsheapintervalNode, b : DsheapintervalNode) -> DsheapintervalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_interval_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_interval_node_copy(s : DsheapintervalNode) -> DsheapintervalNode {
  let result = ds_heap_interval_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_interval_node_fill(s : DsheapintervalNode, v : Double) -> DsheapintervalNode {
  let result = ds_heap_interval_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_node_min(s : DsheapintervalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_node_max(s : DsheapintervalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_node_to_string(s : DsheapintervalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_edge_make(size : Int) -> DsheapintervalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_edge_len(s : DsheapintervalEdge) -> Int { s.size }

pub fn ds_heap_interval_edge_get(s : DsheapintervalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_edge_set(s : DsheapintervalEdge, i : Int, v : Double) -> DsheapintervalEdge {
  let result = ds_heap_interval_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_edge_sum(s : DsheapintervalEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_interval_edge_mean(s : DsheapintervalEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_interval_edge_sum(s) / s.size.to_double() }
}

pub fn ds_heap_interval_edge_scale(s : DsheapintervalEdge, f : Double) -> DsheapintervalEdge {
  let result = ds_heap_interval_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_interval_edge_add(a : DsheapintervalEdge, b : DsheapintervalEdge) -> DsheapintervalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_interval_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_interval_edge_copy(s : DsheapintervalEdge) -> DsheapintervalEdge {
  let result = ds_heap_interval_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_interval_edge_fill(s : DsheapintervalEdge, v : Double) -> DsheapintervalEdge {
  let result = ds_heap_interval_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_edge_min(s : DsheapintervalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_edge_max(s : DsheapintervalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_edge_to_string(s : DsheapintervalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_path_make(size : Int) -> DsheapintervalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_path_len(s : DsheapintervalPath) -> Int { s.size }

pub fn ds_heap_interval_path_get(s : DsheapintervalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_path_set(s : DsheapintervalPath, i : Int, v : Double) -> DsheapintervalPath {
  let result = ds_heap_interval_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_path_sum(s : DsheapintervalPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_interval_path_mean(s : DsheapintervalPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_interval_path_sum(s) / s.size.to_double() }
}

pub fn ds_heap_interval_path_scale(s : DsheapintervalPath, f : Double) -> DsheapintervalPath {
  let result = ds_heap_interval_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_interval_path_add(a : DsheapintervalPath, b : DsheapintervalPath) -> DsheapintervalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_interval_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_interval_path_copy(s : DsheapintervalPath) -> DsheapintervalPath {
  let result = ds_heap_interval_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_interval_path_fill(s : DsheapintervalPath, v : Double) -> DsheapintervalPath {
  let result = ds_heap_interval_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_path_min(s : DsheapintervalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_path_max(s : DsheapintervalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_path_to_string(s : DsheapintervalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_cluster_make(size : Int) -> DsheapintervalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_cluster_len(s : DsheapintervalCluster) -> Int { s.size }

pub fn ds_heap_interval_cluster_get(s : DsheapintervalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_cluster_set(s : DsheapintervalCluster, i : Int, v : Double) -> DsheapintervalCluster {
  let result = ds_heap_interval_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_cluster_sum(s : DsheapintervalCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_interval_cluster_mean(s : DsheapintervalCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_interval_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_heap_interval_cluster_scale(s : DsheapintervalCluster, f : Double) -> DsheapintervalCluster {
  let result = ds_heap_interval_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_interval_cluster_add(a : DsheapintervalCluster, b : DsheapintervalCluster) -> DsheapintervalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_interval_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_interval_cluster_copy(s : DsheapintervalCluster) -> DsheapintervalCluster {
  let result = ds_heap_interval_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_interval_cluster_fill(s : DsheapintervalCluster, v : Double) -> DsheapintervalCluster {
  let result = ds_heap_interval_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_cluster_min(s : DsheapintervalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_cluster_max(s : DsheapintervalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_cluster_to_string(s : DsheapintervalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_model_make(size : Int) -> DsheapintervalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_model_len(s : DsheapintervalModel) -> Int { s.size }

pub fn ds_heap_interval_model_get(s : DsheapintervalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_model_set(s : DsheapintervalModel, i : Int, v : Double) -> DsheapintervalModel {
  let result = ds_heap_interval_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_model_sum(s : DsheapintervalModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_interval_model_mean(s : DsheapintervalModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_interval_model_sum(s) / s.size.to_double() }
}

pub fn ds_heap_interval_model_scale(s : DsheapintervalModel, f : Double) -> DsheapintervalModel {
  let result = ds_heap_interval_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_interval_model_add(a : DsheapintervalModel, b : DsheapintervalModel) -> DsheapintervalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_interval_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_interval_model_copy(s : DsheapintervalModel) -> DsheapintervalModel {
  let result = ds_heap_interval_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_interval_model_fill(s : DsheapintervalModel, v : Double) -> DsheapintervalModel {
  let result = ds_heap_interval_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_model_min(s : DsheapintervalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_model_max(s : DsheapintervalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_model_to_string(s : DsheapintervalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_layer_make(size : Int) -> DsheapintervalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_layer_len(s : DsheapintervalLayer) -> Int { s.size }

pub fn ds_heap_interval_layer_get(s : DsheapintervalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_layer_set(s : DsheapintervalLayer, i : Int, v : Double) -> DsheapintervalLayer {
  let result = ds_heap_interval_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_layer_sum(s : DsheapintervalLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_interval_layer_mean(s : DsheapintervalLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_interval_layer_sum(s) / s.size.to_double() }
}

pub fn ds_heap_interval_layer_scale(s : DsheapintervalLayer, f : Double) -> DsheapintervalLayer {
  let result = ds_heap_interval_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_interval_layer_add(a : DsheapintervalLayer, b : DsheapintervalLayer) -> DsheapintervalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_interval_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_interval_layer_copy(s : DsheapintervalLayer) -> DsheapintervalLayer {
  let result = ds_heap_interval_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_interval_layer_fill(s : DsheapintervalLayer, v : Double) -> DsheapintervalLayer {
  let result = ds_heap_interval_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_layer_min(s : DsheapintervalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_layer_max(s : DsheapintervalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_layer_to_string(s : DsheapintervalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_buffer_make(size : Int) -> DsheapintervalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_buffer_len(s : DsheapintervalBuffer) -> Int { s.size }

pub fn ds_heap_interval_buffer_get(s : DsheapintervalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_buffer_set(s : DsheapintervalBuffer, i : Int, v : Double) -> DsheapintervalBuffer {
  let result = ds_heap_interval_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_buffer_sum(s : DsheapintervalBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_interval_buffer_mean(s : DsheapintervalBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_interval_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_heap_interval_buffer_scale(s : DsheapintervalBuffer, f : Double) -> DsheapintervalBuffer {
  let result = ds_heap_interval_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_interval_buffer_add(a : DsheapintervalBuffer, b : DsheapintervalBuffer) -> DsheapintervalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_interval_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_interval_buffer_copy(s : DsheapintervalBuffer) -> DsheapintervalBuffer {
  let result = ds_heap_interval_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_interval_buffer_fill(s : DsheapintervalBuffer, v : Double) -> DsheapintervalBuffer {
  let result = ds_heap_interval_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_buffer_min(s : DsheapintervalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_buffer_max(s : DsheapintervalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_buffer_to_string(s : DsheapintervalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_cursor_make(size : Int) -> DsheapintervalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_cursor_len(s : DsheapintervalCursor) -> Int { s.size }

pub fn ds_heap_interval_cursor_get(s : DsheapintervalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_cursor_set(s : DsheapintervalCursor, i : Int, v : Double) -> DsheapintervalCursor {
  let result = ds_heap_interval_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_cursor_sum(s : DsheapintervalCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_interval_cursor_mean(s : DsheapintervalCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_interval_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_heap_interval_cursor_scale(s : DsheapintervalCursor, f : Double) -> DsheapintervalCursor {
  let result = ds_heap_interval_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_interval_cursor_add(a : DsheapintervalCursor, b : DsheapintervalCursor) -> DsheapintervalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_interval_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_interval_cursor_copy(s : DsheapintervalCursor) -> DsheapintervalCursor {
  let result = ds_heap_interval_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_interval_cursor_fill(s : DsheapintervalCursor, v : Double) -> DsheapintervalCursor {
  let result = ds_heap_interval_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_cursor_min(s : DsheapintervalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_cursor_max(s : DsheapintervalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_cursor_to_string(s : DsheapintervalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_view_make(size : Int) -> DsheapintervalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_view_len(s : DsheapintervalView) -> Int { s.size }

pub fn ds_heap_interval_view_get(s : DsheapintervalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_view_set(s : DsheapintervalView, i : Int, v : Double) -> DsheapintervalView {
  let result = ds_heap_interval_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_view_sum(s : DsheapintervalView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_interval_view_mean(s : DsheapintervalView) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_interval_view_sum(s) / s.size.to_double() }
}

pub fn ds_heap_interval_view_scale(s : DsheapintervalView, f : Double) -> DsheapintervalView {
  let result = ds_heap_interval_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_interval_view_add(a : DsheapintervalView, b : DsheapintervalView) -> DsheapintervalView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_interval_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_interval_view_copy(s : DsheapintervalView) -> DsheapintervalView {
  let result = ds_heap_interval_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_interval_view_fill(s : DsheapintervalView, v : Double) -> DsheapintervalView {
  let result = ds_heap_interval_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_view_min(s : DsheapintervalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_view_max(s : DsheapintervalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_view_to_string(s : DsheapintervalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_range_make(size : Int) -> DsheapintervalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_range_len(s : DsheapintervalRange) -> Int { s.size }

pub fn ds_heap_interval_range_get(s : DsheapintervalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_range_set(s : DsheapintervalRange, i : Int, v : Double) -> DsheapintervalRange {
  let result = ds_heap_interval_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_range_sum(s : DsheapintervalRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_interval_range_mean(s : DsheapintervalRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_interval_range_sum(s) / s.size.to_double() }
}

pub fn ds_heap_interval_range_scale(s : DsheapintervalRange, f : Double) -> DsheapintervalRange {
  let result = ds_heap_interval_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_interval_range_add(a : DsheapintervalRange, b : DsheapintervalRange) -> DsheapintervalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_interval_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_interval_range_copy(s : DsheapintervalRange) -> DsheapintervalRange {
  let result = ds_heap_interval_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_interval_range_fill(s : DsheapintervalRange, v : Double) -> DsheapintervalRange {
  let result = ds_heap_interval_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_range_min(s : DsheapintervalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_range_max(s : DsheapintervalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_range_to_string(s : DsheapintervalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_slice_make(size : Int) -> DsheapintervalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_slice_len(s : DsheapintervalSlice) -> Int { s.size }

pub fn ds_heap_interval_slice_get(s : DsheapintervalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_slice_set(s : DsheapintervalSlice, i : Int, v : Double) -> DsheapintervalSlice {
  let result = ds_heap_interval_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_slice_sum(s : DsheapintervalSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_interval_slice_mean(s : DsheapintervalSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_interval_slice_sum(s) / s.size.to_double() }
}

pub fn ds_heap_interval_slice_scale(s : DsheapintervalSlice, f : Double) -> DsheapintervalSlice {
  let result = ds_heap_interval_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_interval_slice_add(a : DsheapintervalSlice, b : DsheapintervalSlice) -> DsheapintervalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_interval_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_interval_slice_copy(s : DsheapintervalSlice) -> DsheapintervalSlice {
  let result = ds_heap_interval_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_interval_slice_fill(s : DsheapintervalSlice, v : Double) -> DsheapintervalSlice {
  let result = ds_heap_interval_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_interval_slice_min(s : DsheapintervalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_slice_max(s : DsheapintervalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_interval_slice_to_string(s : DsheapintervalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

