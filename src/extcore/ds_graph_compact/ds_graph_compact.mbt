///===
/// extcore/ds_graph_compact

pub(all) struct DsgraphcompactPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_compact_make_point(x : Double, y : Double) -> DsgraphcompactPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_compact_make_point3(x : Double, y : Double, z : Double) -> DsgraphcompactPoint {
  { x, y, z, label: 0 }
}

pub fn ds_graph_compact_point_x(pt : DsgraphcompactPoint) -> Double { pt.x }

pub fn ds_graph_compact_point_y(pt : DsgraphcompactPoint) -> Double { pt.y }

pub fn ds_graph_compact_point_z(pt : DsgraphcompactPoint) -> Double { pt.z }

pub fn ds_graph_compact_point_label(pt : DsgraphcompactPoint) -> Int { pt.label }

pub fn ds_graph_compact_point_dist(a : DsgraphcompactPoint, b : DsgraphcompactPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_graph_compact_point_add(a : DsgraphcompactPoint, b : DsgraphcompactPoint) -> DsgraphcompactPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_graph_compact_point_sub(a : DsgraphcompactPoint, b : DsgraphcompactPoint) -> DsgraphcompactPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_graph_compact_point_scale(pt : DsgraphcompactPoint, s : Double) -> DsgraphcompactPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_graph_compact_point_dot(a : DsgraphcompactPoint, b : DsgraphcompactPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_graph_compact_point_cross(a : DsgraphcompactPoint, b : DsgraphcompactPoint) -> DsgraphcompactPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_graph_compact_point_norm(pt : DsgraphcompactPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_graph_compact_point_normalize(pt : DsgraphcompactPoint) -> DsgraphcompactPoint {
  let n = ds_graph_compact_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_graph_compact_point_scale(pt, 1.0 / n) }
}

pub fn ds_graph_compact_point_negate(pt : DsgraphcompactPoint) -> DsgraphcompactPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_graph_compact_point_mid(a : DsgraphcompactPoint, b : DsgraphcompactPoint) -> DsgraphcompactPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_graph_compact_point_lerp(a : DsgraphcompactPoint, b : DsgraphcompactPoint, t : Double) -> DsgraphcompactPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_graph_compact_point_to_string(pt : DsgraphcompactPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsgraphcompactSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_compact_make_series(vals : Array[Double], name : String) -> DsgraphcompactSeries {
  { vals, name, meta: 0 }
}

pub fn ds_graph_compact_series_len(s : DsgraphcompactSeries) -> Int { s.vals.length() }

pub fn ds_graph_compact_series_sum(s : DsgraphcompactSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_graph_compact_series_mean(s : DsgraphcompactSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_graph_compact_series_min(s : DsgraphcompactSeries) -> Double { @_common.min(s.vals) }

pub fn ds_graph_compact_series_max(s : DsgraphcompactSeries) -> Double { @_common.max(s.vals) }

pub fn ds_graph_compact_series_range(s : DsgraphcompactSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_graph_compact_series_var(s : DsgraphcompactSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_graph_compact_series_std(s : DsgraphcompactSeries) -> Double { @_common.std(s.vals) }

pub fn ds_graph_compact_series_median(s : DsgraphcompactSeries) -> Double { @_common.median(s.vals) }

pub fn ds_graph_compact_series_scale(s : DsgraphcompactSeries, f : Double) -> DsgraphcompactSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_graph_compact_series_add(a : DsgraphcompactSeries, b : DsgraphcompactSeries) -> DsgraphcompactSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_graph_compact_series_sub(a : DsgraphcompactSeries, b : DsgraphcompactSeries) -> DsgraphcompactSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_graph_compact_series_normalize(s : DsgraphcompactSeries) -> DsgraphcompactSeries {
  let mn = ds_graph_compact_series_min(s)
  let mx = ds_graph_compact_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_graph_compact_series_cumsum(s : DsgraphcompactSeries) -> DsgraphcompactSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_graph_compact_series_to_string(s : DsgraphcompactSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphcompactMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_compact_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphcompactMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_compact_matrix_identity(n : Int) -> DsgraphcompactMatrix {
  let m = ds_graph_compact_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_graph_compact_matrix_get(m : DsgraphcompactMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_graph_compact_matrix_transpose(m : DsgraphcompactMatrix) -> DsgraphcompactMatrix {
  let result = ds_graph_compact_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_graph_compact_matrix_add(a : DsgraphcompactMatrix, b : DsgraphcompactMatrix) -> DsgraphcompactMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_graph_compact_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_graph_compact_matrix_scale(m : DsgraphcompactMatrix, s : Double) -> DsgraphcompactMatrix {
  let result = ds_graph_compact_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_graph_compact_matrix_multiply(a : DsgraphcompactMatrix, b : DsgraphcompactMatrix) -> DsgraphcompactMatrix {
  if a.cols != b.rows { return ds_graph_compact_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_graph_compact_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_graph_compact_matrix_trace(m : DsgraphcompactMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_graph_compact_matrix_det(m : DsgraphcompactMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_graph_compact_matrix_norm(m : DsgraphcompactMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_graph_compact_matrix_to_string(m : DsgraphcompactMatrix) -> String {
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

pub(all) struct DsgraphcompactVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_compact_make_vector(comps : Array[Double]) -> DsgraphcompactVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_compact_vector_zero(dim : Int) -> DsgraphcompactVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_graph_compact_vector_add(a : DsgraphcompactVector, b : DsgraphcompactVector) -> DsgraphcompactVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_graph_compact_vector_sub(a : DsgraphcompactVector, b : DsgraphcompactVector) -> DsgraphcompactVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_graph_compact_vector_scale(v : DsgraphcompactVector, s : Double) -> DsgraphcompactVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_graph_compact_vector_dot(a : DsgraphcompactVector, b : DsgraphcompactVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_graph_compact_vector_norm(v : DsgraphcompactVector) -> Double { @_common.sqrt(ds_graph_compact_vector_dot(v, v)) }

pub fn ds_graph_compact_vector_normalize(v : DsgraphcompactVector) -> DsgraphcompactVector {
  let n = ds_graph_compact_vector_norm(v)
  if n < 0.0000001 { v } else { ds_graph_compact_vector_scale(v, 1.0 / n) }
}

pub fn ds_graph_compact_vector_dist(a : DsgraphcompactVector, b : DsgraphcompactVector) -> Double {
  ds_graph_compact_vector_norm(ds_graph_compact_vector_sub(a, b))
}

pub fn ds_graph_compact_vector_to_string(v : DsgraphcompactVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_compact_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_graph_compact_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_graph_compact_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_graph_compact_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_graph_compact_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_graph_compact_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_graph_compact_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_graph_compact_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_graph_compact_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_graph_compact_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_graph_compact_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_graph_compact_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_graph_compact_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_graph_compact_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_graph_compact_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_graph_compact_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_graph_compact_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_graph_compact_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_graph_compact_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_graph_compact_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_graph_compact_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_graph_compact_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_graph_compact_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_graph_compact_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_graph_compact_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_graph_compact_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_graph_compact_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_graph_compact_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_graph_compact_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsgraphcompactFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_frame_make(size : Int) -> DsgraphcompactFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_frame_len(s : DsgraphcompactFrame) -> Int { s.size }

pub fn ds_graph_compact_frame_get(s : DsgraphcompactFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_frame_set(s : DsgraphcompactFrame, i : Int, v : Double) -> DsgraphcompactFrame {
  let result = ds_graph_compact_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_frame_sum(s : DsgraphcompactFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_frame_mean(s : DsgraphcompactFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_frame_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_frame_scale(s : DsgraphcompactFrame, f : Double) -> DsgraphcompactFrame {
  let result = ds_graph_compact_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_frame_add(a : DsgraphcompactFrame, b : DsgraphcompactFrame) -> DsgraphcompactFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_frame_copy(s : DsgraphcompactFrame) -> DsgraphcompactFrame {
  let result = ds_graph_compact_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_frame_fill(s : DsgraphcompactFrame, v : Double) -> DsgraphcompactFrame {
  let result = ds_graph_compact_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_frame_min(s : DsgraphcompactFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_frame_max(s : DsgraphcompactFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_frame_to_string(s : DsgraphcompactFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_table_make(size : Int) -> DsgraphcompactTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_table_len(s : DsgraphcompactTable) -> Int { s.size }

pub fn ds_graph_compact_table_get(s : DsgraphcompactTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_table_set(s : DsgraphcompactTable, i : Int, v : Double) -> DsgraphcompactTable {
  let result = ds_graph_compact_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_table_sum(s : DsgraphcompactTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_table_mean(s : DsgraphcompactTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_table_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_table_scale(s : DsgraphcompactTable, f : Double) -> DsgraphcompactTable {
  let result = ds_graph_compact_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_table_add(a : DsgraphcompactTable, b : DsgraphcompactTable) -> DsgraphcompactTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_table_copy(s : DsgraphcompactTable) -> DsgraphcompactTable {
  let result = ds_graph_compact_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_table_fill(s : DsgraphcompactTable, v : Double) -> DsgraphcompactTable {
  let result = ds_graph_compact_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_table_min(s : DsgraphcompactTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_table_max(s : DsgraphcompactTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_table_to_string(s : DsgraphcompactTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_graphn_make(size : Int) -> DsgraphcompactGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_graphn_len(s : DsgraphcompactGraphN) -> Int { s.size }

pub fn ds_graph_compact_graphn_get(s : DsgraphcompactGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_graphn_set(s : DsgraphcompactGraphN, i : Int, v : Double) -> DsgraphcompactGraphN {
  let result = ds_graph_compact_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_graphn_sum(s : DsgraphcompactGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_graphn_mean(s : DsgraphcompactGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_graphn_scale(s : DsgraphcompactGraphN, f : Double) -> DsgraphcompactGraphN {
  let result = ds_graph_compact_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_graphn_add(a : DsgraphcompactGraphN, b : DsgraphcompactGraphN) -> DsgraphcompactGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_graphn_copy(s : DsgraphcompactGraphN) -> DsgraphcompactGraphN {
  let result = ds_graph_compact_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_graphn_fill(s : DsgraphcompactGraphN, v : Double) -> DsgraphcompactGraphN {
  let result = ds_graph_compact_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_graphn_min(s : DsgraphcompactGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_graphn_max(s : DsgraphcompactGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_graphn_to_string(s : DsgraphcompactGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_node_make(size : Int) -> DsgraphcompactNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_node_len(s : DsgraphcompactNode) -> Int { s.size }

pub fn ds_graph_compact_node_get(s : DsgraphcompactNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_node_set(s : DsgraphcompactNode, i : Int, v : Double) -> DsgraphcompactNode {
  let result = ds_graph_compact_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_node_sum(s : DsgraphcompactNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_node_mean(s : DsgraphcompactNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_node_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_node_scale(s : DsgraphcompactNode, f : Double) -> DsgraphcompactNode {
  let result = ds_graph_compact_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_node_add(a : DsgraphcompactNode, b : DsgraphcompactNode) -> DsgraphcompactNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_node_copy(s : DsgraphcompactNode) -> DsgraphcompactNode {
  let result = ds_graph_compact_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_node_fill(s : DsgraphcompactNode, v : Double) -> DsgraphcompactNode {
  let result = ds_graph_compact_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_node_min(s : DsgraphcompactNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_node_max(s : DsgraphcompactNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_node_to_string(s : DsgraphcompactNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_edge_make(size : Int) -> DsgraphcompactEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_edge_len(s : DsgraphcompactEdge) -> Int { s.size }

pub fn ds_graph_compact_edge_get(s : DsgraphcompactEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_edge_set(s : DsgraphcompactEdge, i : Int, v : Double) -> DsgraphcompactEdge {
  let result = ds_graph_compact_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_edge_sum(s : DsgraphcompactEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_edge_mean(s : DsgraphcompactEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_edge_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_edge_scale(s : DsgraphcompactEdge, f : Double) -> DsgraphcompactEdge {
  let result = ds_graph_compact_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_edge_add(a : DsgraphcompactEdge, b : DsgraphcompactEdge) -> DsgraphcompactEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_edge_copy(s : DsgraphcompactEdge) -> DsgraphcompactEdge {
  let result = ds_graph_compact_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_edge_fill(s : DsgraphcompactEdge, v : Double) -> DsgraphcompactEdge {
  let result = ds_graph_compact_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_edge_min(s : DsgraphcompactEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_edge_max(s : DsgraphcompactEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_edge_to_string(s : DsgraphcompactEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_path_make(size : Int) -> DsgraphcompactPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_path_len(s : DsgraphcompactPath) -> Int { s.size }

pub fn ds_graph_compact_path_get(s : DsgraphcompactPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_path_set(s : DsgraphcompactPath, i : Int, v : Double) -> DsgraphcompactPath {
  let result = ds_graph_compact_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_path_sum(s : DsgraphcompactPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_path_mean(s : DsgraphcompactPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_path_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_path_scale(s : DsgraphcompactPath, f : Double) -> DsgraphcompactPath {
  let result = ds_graph_compact_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_path_add(a : DsgraphcompactPath, b : DsgraphcompactPath) -> DsgraphcompactPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_path_copy(s : DsgraphcompactPath) -> DsgraphcompactPath {
  let result = ds_graph_compact_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_path_fill(s : DsgraphcompactPath, v : Double) -> DsgraphcompactPath {
  let result = ds_graph_compact_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_path_min(s : DsgraphcompactPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_path_max(s : DsgraphcompactPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_path_to_string(s : DsgraphcompactPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_cluster_make(size : Int) -> DsgraphcompactCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_cluster_len(s : DsgraphcompactCluster) -> Int { s.size }

pub fn ds_graph_compact_cluster_get(s : DsgraphcompactCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_cluster_set(s : DsgraphcompactCluster, i : Int, v : Double) -> DsgraphcompactCluster {
  let result = ds_graph_compact_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_cluster_sum(s : DsgraphcompactCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_cluster_mean(s : DsgraphcompactCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_cluster_scale(s : DsgraphcompactCluster, f : Double) -> DsgraphcompactCluster {
  let result = ds_graph_compact_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_cluster_add(a : DsgraphcompactCluster, b : DsgraphcompactCluster) -> DsgraphcompactCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_cluster_copy(s : DsgraphcompactCluster) -> DsgraphcompactCluster {
  let result = ds_graph_compact_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_cluster_fill(s : DsgraphcompactCluster, v : Double) -> DsgraphcompactCluster {
  let result = ds_graph_compact_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_cluster_min(s : DsgraphcompactCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_cluster_max(s : DsgraphcompactCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_cluster_to_string(s : DsgraphcompactCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_model_make(size : Int) -> DsgraphcompactModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_model_len(s : DsgraphcompactModel) -> Int { s.size }

pub fn ds_graph_compact_model_get(s : DsgraphcompactModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_model_set(s : DsgraphcompactModel, i : Int, v : Double) -> DsgraphcompactModel {
  let result = ds_graph_compact_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_model_sum(s : DsgraphcompactModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_model_mean(s : DsgraphcompactModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_model_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_model_scale(s : DsgraphcompactModel, f : Double) -> DsgraphcompactModel {
  let result = ds_graph_compact_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_model_add(a : DsgraphcompactModel, b : DsgraphcompactModel) -> DsgraphcompactModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_model_copy(s : DsgraphcompactModel) -> DsgraphcompactModel {
  let result = ds_graph_compact_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_model_fill(s : DsgraphcompactModel, v : Double) -> DsgraphcompactModel {
  let result = ds_graph_compact_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_model_min(s : DsgraphcompactModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_model_max(s : DsgraphcompactModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_model_to_string(s : DsgraphcompactModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_layer_make(size : Int) -> DsgraphcompactLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_layer_len(s : DsgraphcompactLayer) -> Int { s.size }

pub fn ds_graph_compact_layer_get(s : DsgraphcompactLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_layer_set(s : DsgraphcompactLayer, i : Int, v : Double) -> DsgraphcompactLayer {
  let result = ds_graph_compact_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_layer_sum(s : DsgraphcompactLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_layer_mean(s : DsgraphcompactLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_layer_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_layer_scale(s : DsgraphcompactLayer, f : Double) -> DsgraphcompactLayer {
  let result = ds_graph_compact_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_layer_add(a : DsgraphcompactLayer, b : DsgraphcompactLayer) -> DsgraphcompactLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_layer_copy(s : DsgraphcompactLayer) -> DsgraphcompactLayer {
  let result = ds_graph_compact_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_layer_fill(s : DsgraphcompactLayer, v : Double) -> DsgraphcompactLayer {
  let result = ds_graph_compact_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_layer_min(s : DsgraphcompactLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_layer_max(s : DsgraphcompactLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_layer_to_string(s : DsgraphcompactLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_buffer_make(size : Int) -> DsgraphcompactBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_buffer_len(s : DsgraphcompactBuffer) -> Int { s.size }

pub fn ds_graph_compact_buffer_get(s : DsgraphcompactBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_buffer_set(s : DsgraphcompactBuffer, i : Int, v : Double) -> DsgraphcompactBuffer {
  let result = ds_graph_compact_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_buffer_sum(s : DsgraphcompactBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_buffer_mean(s : DsgraphcompactBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_buffer_scale(s : DsgraphcompactBuffer, f : Double) -> DsgraphcompactBuffer {
  let result = ds_graph_compact_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_buffer_add(a : DsgraphcompactBuffer, b : DsgraphcompactBuffer) -> DsgraphcompactBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_buffer_copy(s : DsgraphcompactBuffer) -> DsgraphcompactBuffer {
  let result = ds_graph_compact_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_buffer_fill(s : DsgraphcompactBuffer, v : Double) -> DsgraphcompactBuffer {
  let result = ds_graph_compact_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_buffer_min(s : DsgraphcompactBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_buffer_max(s : DsgraphcompactBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_buffer_to_string(s : DsgraphcompactBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_cursor_make(size : Int) -> DsgraphcompactCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_cursor_len(s : DsgraphcompactCursor) -> Int { s.size }

pub fn ds_graph_compact_cursor_get(s : DsgraphcompactCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_cursor_set(s : DsgraphcompactCursor, i : Int, v : Double) -> DsgraphcompactCursor {
  let result = ds_graph_compact_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_cursor_sum(s : DsgraphcompactCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_cursor_mean(s : DsgraphcompactCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_cursor_scale(s : DsgraphcompactCursor, f : Double) -> DsgraphcompactCursor {
  let result = ds_graph_compact_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_cursor_add(a : DsgraphcompactCursor, b : DsgraphcompactCursor) -> DsgraphcompactCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_cursor_copy(s : DsgraphcompactCursor) -> DsgraphcompactCursor {
  let result = ds_graph_compact_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_cursor_fill(s : DsgraphcompactCursor, v : Double) -> DsgraphcompactCursor {
  let result = ds_graph_compact_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_cursor_min(s : DsgraphcompactCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_cursor_max(s : DsgraphcompactCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_cursor_to_string(s : DsgraphcompactCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_view_make(size : Int) -> DsgraphcompactView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_view_len(s : DsgraphcompactView) -> Int { s.size }

pub fn ds_graph_compact_view_get(s : DsgraphcompactView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_view_set(s : DsgraphcompactView, i : Int, v : Double) -> DsgraphcompactView {
  let result = ds_graph_compact_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_view_sum(s : DsgraphcompactView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_view_mean(s : DsgraphcompactView) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_view_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_view_scale(s : DsgraphcompactView, f : Double) -> DsgraphcompactView {
  let result = ds_graph_compact_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_view_add(a : DsgraphcompactView, b : DsgraphcompactView) -> DsgraphcompactView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_view_copy(s : DsgraphcompactView) -> DsgraphcompactView {
  let result = ds_graph_compact_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_view_fill(s : DsgraphcompactView, v : Double) -> DsgraphcompactView {
  let result = ds_graph_compact_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_view_min(s : DsgraphcompactView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_view_max(s : DsgraphcompactView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_view_to_string(s : DsgraphcompactView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_range_make(size : Int) -> DsgraphcompactRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_range_len(s : DsgraphcompactRange) -> Int { s.size }

pub fn ds_graph_compact_range_get(s : DsgraphcompactRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_range_set(s : DsgraphcompactRange, i : Int, v : Double) -> DsgraphcompactRange {
  let result = ds_graph_compact_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_range_sum(s : DsgraphcompactRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_range_mean(s : DsgraphcompactRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_range_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_range_scale(s : DsgraphcompactRange, f : Double) -> DsgraphcompactRange {
  let result = ds_graph_compact_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_range_add(a : DsgraphcompactRange, b : DsgraphcompactRange) -> DsgraphcompactRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_range_copy(s : DsgraphcompactRange) -> DsgraphcompactRange {
  let result = ds_graph_compact_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_range_fill(s : DsgraphcompactRange, v : Double) -> DsgraphcompactRange {
  let result = ds_graph_compact_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_range_min(s : DsgraphcompactRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_range_max(s : DsgraphcompactRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_range_to_string(s : DsgraphcompactRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_slice_make(size : Int) -> DsgraphcompactSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_slice_len(s : DsgraphcompactSlice) -> Int { s.size }

pub fn ds_graph_compact_slice_get(s : DsgraphcompactSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_slice_set(s : DsgraphcompactSlice, i : Int, v : Double) -> DsgraphcompactSlice {
  let result = ds_graph_compact_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_slice_sum(s : DsgraphcompactSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_slice_mean(s : DsgraphcompactSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_slice_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_slice_scale(s : DsgraphcompactSlice, f : Double) -> DsgraphcompactSlice {
  let result = ds_graph_compact_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_slice_add(a : DsgraphcompactSlice, b : DsgraphcompactSlice) -> DsgraphcompactSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_slice_copy(s : DsgraphcompactSlice) -> DsgraphcompactSlice {
  let result = ds_graph_compact_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_slice_fill(s : DsgraphcompactSlice, v : Double) -> DsgraphcompactSlice {
  let result = ds_graph_compact_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_slice_min(s : DsgraphcompactSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_slice_max(s : DsgraphcompactSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_slice_to_string(s : DsgraphcompactSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

